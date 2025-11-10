Return-Path: <linux-api+bounces-5196-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE76C48660
	for <lists+linux-api@lfdr.de>; Mon, 10 Nov 2025 18:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE913AC752
	for <lists+linux-api@lfdr.de>; Mon, 10 Nov 2025 17:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96D62DE6F5;
	Mon, 10 Nov 2025 17:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="APWm8CP+"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDF32DCC1C
	for <linux-api@vger.kernel.org>; Mon, 10 Nov 2025 17:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796580; cv=none; b=cdzLk8ExWtJHUPFvtQqbwEpgHYFiqfPhOpS01GJE1LzO7LwYjnunlsaScW0bcfHTAY5IKoDZQpArhhzGMKNKIjDvS/n+Ylcxp3uen6uNDdJ97fXqni5tFvxV1WaNBHMQerjZd/wXXqF/yJL6eRjvDIS5lWDaYrQTbpYVBTIAFNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796580; c=relaxed/simple;
	bh=1jUZUYtOVtlvHWAFniX5k1AQ7sW+PemaRKAUKppWEUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOiLynhyzOWyVDZK60MDbUhaq57VyLHEEhEa141XtkyXQx0jM8dKu0EpePXtufA1rV0iuUD7XSw74QP2HFKNEmSn+2394+PaUzgXmT+rmqbv3gqy065CkILp+CuTSRMfO3WTqK+Ap9aU559DTcxFPapo3I+0dsXj6yhXB+7jLRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=APWm8CP+; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso2917094a12.3
        for <linux-api@vger.kernel.org>; Mon, 10 Nov 2025 09:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762796577; x=1763401377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUewd4yleLJA5JoGTJV3GbsdDnDLJGqt03O6urjLvaA=;
        b=APWm8CP+ROuK9JraWpsJmgK1GfiEaPZowkjDlst+mroLWWAtMwyphwXCL5Oue3RYwM
         fKE1tmuDTfKak8a2uZLOIrOjsremCBdbNl7MsUbOKNqI1sJ4nBXl9gnFA+iYU1JoSpxX
         H0m2Pj0VmW2qbjEYRyP3AZK/mRFRmPNxChW+yqcwYIWeQYoekghRu6E0nDaW6qW/OXXr
         JUple65wvQ+EWi0qMue5VABMkAGG7yZOqiI+ONOTQmyFXZwGQ3xRnlRSI7Hvdo/ifbde
         Q9OnTLgAlYN9elOs/c1ZKmU4Xd14QoOn8AVNMgf9q7ZrqSHNUwKxBeTqzfkLn4yLHrk0
         yn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762796577; x=1763401377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dUewd4yleLJA5JoGTJV3GbsdDnDLJGqt03O6urjLvaA=;
        b=KwfaLsrBiIZOp0neewrzhBB2rdO6dGY6GLF/EuXdnKx0GCmEzYu/xtrIh+H+NmAg0D
         NKM3Afy4ymQYXMXDF5G3V0+jxH9eV6Iaa2RX/HhsA7ieR/0p2nXF371HGE5v2Njmj01G
         ZtPYY26ELCx3DYaibTBc//DW4qGovnw7jlIJEVYN+uhVHFi2+SmsdCwI1bHOMwaCHmQO
         HpGjpOJPtD8kabco5/x9DPmm1ZPZ2cAba2ZwYthdOoKGW8oTj0+rYab5VthYWfzlSHyv
         JPUs/QyRJbUbondTHxjt/U2zXjMqvvu4rR7skRO3HcOVc5GQIhARufLPz9L6jE/bfiCq
         r1dw==
X-Forwarded-Encrypted: i=1; AJvYcCUGrDVCgv7M+X/hleHJzGqbG6YQAhmrpUr+YGFp49q/KnjkWroAKeA3rrBukwJWu8Ox1ddPkKFIM8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy19CXc6n4Xrc+SVwW5B/ycWrVEbILZnsbNDekuzs0qraaOChHj
	73Fa/lJ0LLmX7NmAxVEmyFwljxpJRKYfVCNd6FBQ2KtMmPcYM7yIfe0Hwe9LMOaT8cPaY6Lg3H8
	OVu/ICc7X6HpQY3HS6jDrD181UNMZH5FaUZCxVIPhoA==
X-Gm-Gg: ASbGncvKY37ihj7rOBmOyVtbFAzmPTXH5DFR0QNVMEmPLSWShmGoluFzDUfKZWTe5YH
	J5JZ3OgSIf07saROboz6yQxxDyO2a0SrH9G8TvjEf1rlnj01qxHe+pJl8Zs/4AjHHAUVZMa7701
	Nc66//J5hzq9BNyizKB1VHZI03pSPVPxiWD69kmKIC6lRiUdH3vWbUvbMw2FyxEMPMhG/nvb5ww
	CUcmSIa32XnmOqRByXMpuqAYBPlMA6Ao/IAUQK1FsmX6sZagfOs41H1fBt0Cdi2AxKS
X-Google-Smtp-Source: AGHT+IGohd97iFSzusnKQDkeinSJTmpnCSTGsIETDXka805LYidOh0KbeB0Llp5c7t8ysAzDBzzykZsDEtrUy45tKnE=
X-Received: by 2002:a05:6402:1ec5:b0:640:80cc:f08e with SMTP id
 4fb4d7f45d1cf-6415e83dbc4mr7456751a12.26.1762796576718; Mon, 10 Nov 2025
 09:42:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-9-pasha.tatashin@soleen.com> <mafs0ms4tajcs.fsf@kernel.org>
In-Reply-To: <mafs0ms4tajcs.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 10 Nov 2025 12:42:20 -0500
X-Gm-Features: AWmQ_bmosonxcvpRMVKb6ujiu2Wwb5WZcJ_Ml7LhP2hix7ibfaliD6vYbfTF0S4
Message-ID: <CA+CK2bCWeqLmndDa8eg+iLrSBHg0XAvMr0mHeKSeH0Y=6F02kQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/22] liveupdate: luo_file: implement file systems callbacks
To: Pratyush Yadav <pratyush@kernel.org>
Cc: jasonmiu@google.com, graf@amazon.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com, hughd@google.com, skhawaja@google.com, chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 12:27=E2=80=AFPM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> Hi Pasha,
>
> Caught a small bug during some of my testing.
>
> On Fri, Nov 07 2025, Pasha Tatashin wrote:
>
> > This patch implements the core mechanism for managing preserved
> > files throughout the live update lifecycle. It provides the logic to
> > invoke the file handler callbacks (preserve, unpreserve, freeze,
> > unfreeze, retrieve, and finish) at the appropriate stages.
> >
> > During the reboot phase, luo_file_freeze() serializes the final
> > metadata for each file (handler compatible string, token, and data
> > handle) into a memory region preserved by KHO. In the new kernel,
> > luo_file_deserialize() reconstructs the in-memory file list from this
> > data, preparing the session for retrieval.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> [...]
> > +int luo_preserve_file(struct luo_session *session, u64 token, int fd)
> > +{
> > +     struct liveupdate_file_op_args args =3D {0};
> > +     struct liveupdate_file_handler *fh;
> > +     struct luo_file *luo_file;
> > +     struct file *file;
> > +     int err =3D -ENOENT;
> > +
> > +     lockdep_assert_held(&session->mutex);
> > +
> > +     if (luo_token_is_used(session, token))
> > +             return -EEXIST;
> > +
> > +     file =3D fget(fd);
> > +     if (!file)
> > +             return -EBADF;
> > +
> > +     err =3D luo_session_alloc_files_mem(session);
>
> err gets set to 0 here...
>
> > +     if (err)
> > +             goto  exit_err;
> > +
> > +     if (session->count =3D=3D LUO_FILE_MAX) {
> > +             err =3D -ENOSPC;
> > +             goto exit_err;
> > +     }
> > +
> > +     list_for_each_entry(fh, &luo_file_handler_list, list) {
> > +             if (fh->ops->can_preserve(fh, file)) {
> > +                     err =3D 0;
> > +                     break;
> > +             }
> > +     }
>
> ... say no file handler can preserve this file ...
>
> > +
> > +     /* err is still -ENOENT if no handler was found */
> > +     if (err)
>
> ... err is not ENOENT, but 0. So this function does not error but, but
> goes ahead with fh =3D=3D luo_file_handler_list (since end of list). This
> causes an out-of-bounds access. It eventually causes a kernel fault and
> panic.
>
> You should drop the ENOENT at initialization time and set it right
> before list_for_each_entry().

Right, thank you for reporting this. Should add it to self-tests,
where we try to preserve FD that does not have a file handler.

Pasha

>
> > +             goto exit_err;
> > +
> > +     luo_file =3D kzalloc(sizeof(*luo_file), GFP_KERNEL);
> > +     if (!luo_file) {
> > +             err =3D -ENOMEM;
> > +             goto exit_err;
> > +     }
> > +
> > +     luo_file->file =3D file;
> > +     luo_file->fh =3D fh;
> > +     luo_file->token =3D token;
> > +     luo_file->retrieved =3D false;
> > +     mutex_init(&luo_file->mutex);
> > +
> > +     args.handler =3D fh;
> > +     args.session =3D (struct liveupdate_session *)session;
> > +     args.file =3D file;
> > +     err =3D fh->ops->preserve(&args);
> > +     if (err) {
> > +             mutex_destroy(&luo_file->mutex);
> > +             kfree(luo_file);
> > +             goto exit_err;
> > +     } else {
> > +             luo_file->serialized_data =3D args.serialized_data;
> > +             list_add_tail(&luo_file->list, &session->files_list);
> > +             session->count++;
> > +     }
> > +
> > +     return 0;
> > +
> > +exit_err:
> > +     fput(file);
> > +     luo_session_free_files_mem(session);
> > +
> > +     return err;
> > +}
> [...]
>
> --
> Regards,
> Pratyush Yadav

