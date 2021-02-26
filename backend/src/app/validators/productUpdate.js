import * as Yup from 'yup';

export default async (request, response, next) => {
  try {
    const schema = Yup.object().shape({
      name: Yup.string().required('Nome é obrigatório'),
      description: Yup.string().required('Descrição é obrigatório'),
      price: Yup.number().required('Preço é obrigatório'),
      quantity: Yup.number().required('Quantidade é obrigatório'),
      active: Yup.boolean().required('Active é obrigatório'),
    });
    await schema.validate(request.body, { abortEarly: false });
    return next();
  } catch (err) {
    return response.status(400)
      .json({ error: 'Erro ao atualizar o produto!', messages: err.inner });
  }
};
