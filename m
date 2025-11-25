Return-Path: <linux-api+bounces-5498-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA287C85B87
	for <lists+linux-api@lfdr.de>; Tue, 25 Nov 2025 16:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8FB80348F66
	for <lists+linux-api@lfdr.de>; Tue, 25 Nov 2025 15:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5150E3271FA;
	Tue, 25 Nov 2025 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="bDQXLpLY"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D47B3271E0
	for <linux-api@vger.kernel.org>; Tue, 25 Nov 2025 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764083635; cv=none; b=bI3th6zc5KyRSCi6jkQxlrIxKMeiDOcxhmsMkIvi73G/Te7qpOrvHrNWDlYYm26lPRhmZVcGgJ+fKZfIQTbyJfzk/mnbm8YL5DO+dDbLywFj2YQZsA1pM2dYRAncBh99hIrVtwkA4NkzmerGCCRYzREO1baTOFQviY0RqY9KQww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764083635; c=relaxed/simple;
	bh=y44+7vWiMICS8raonC28WpYQWJl7VjfR7seHcarnwGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8QNtCiwIegXPAzHeWAy7ReKoNtRe5Z/gx6oWUxfOGsy2gPwIEPW9Dfn+AHQ8zppMbuyaPJpL6/4/q1emjoOp9OpDsmBhtIj7JtIrouaHmbAl7nn9TGJXEUyRUqhwS0bMJquq2tiC+M7vZcabM2oGOtTX67N2Exxnt6FWuDnKR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=bDQXLpLY; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so9358116a12.1
        for <linux-api@vger.kernel.org>; Tue, 25 Nov 2025 07:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764083630; x=1764688430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJAb0zqhShPXJU9IU9F3kUJv+d4qBtikcObWfuhaWDU=;
        b=bDQXLpLYuhl/hFO4aWmQNIS1mRu7f5+RtfD3KQnDdQycs0T2aTVUSyDR7m7ZDuX8N9
         raDuqeQelN2hAiAryxketOE9LMrnI/FwA9A0A3XhEUx+6dG050FKuZ5+fjdGKnDTNz6N
         7ktFUf1jNaYZD7e2O5wVUJ0UJ3dIfDL/qnEuxvWYP1K7q1wcwIZDE+s58xN6gtHq1KZn
         1toBkKYOHlSTnwWCeA73whzBXxce1dMWXrwur2mIH2ryqxHu8z0+fpYG81hygG00+LEq
         QHQLLhHH3sMcqRkCpG9RpcsnCzwGcbXBySdhf632/8jtlntzhOW848xFj5WW+XUSbJmb
         vYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764083630; x=1764688430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CJAb0zqhShPXJU9IU9F3kUJv+d4qBtikcObWfuhaWDU=;
        b=oGQtRCc+iRNgupWrgAKHovTs80wXIeUC5eqJCZIMHYpJwSLKzysx2oXCFeRl+nCsVn
         PmW0olMG9t2UsuK4ZazzOQ2HTqjnFl12cRIWHqSV+DcdjJ5gsbkWK7CK3uX0KYvtslY6
         DJqBkLnqbEBtGkXh0rJUKVZgAf/9334cI4PrPtL08smTymzeQRaHDd68QsAaM46vo0ZE
         WzlvNxReIt9F1m4yylYtnxT9MIpBPeqcce5GpRS//565hwNz2Dni3fAkChbgcZnEUaL4
         phCPfw+LGJOqPmfSDswUso6NG4NGMYkqdRh2LTU8VfEBeqskIRtKH42yHXpyKp94LlMx
         KzRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ5gk0y+Imilb56Ptyh72gg3HCYsPP0Q0+lb2+WMcStuVcfCEKdv83rexfbfJWjYBdjYIVgyCOxQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8iKWvF5UNwJMxOX2TMkG6+wVFMYJp+wGwUfEyIDptmxMtWvzk
	QmXMxmWGoR3o5tM3Y282iHQtDRH8NeRlVV8O9CPU7UNN+GclFcvdcirc/GSzDyRoo56lMV92CRC
	7TAMrcuOFU7L4FFW2be4O1dg59aIvTmMVIzSdWbw/TQ==
X-Gm-Gg: ASbGnctuPS11O3T1rctT7V2qYGWvDK8ijtZOKHNp+bkplv7JK2VyEeloCE5cTugLrwL
	nw2gmP8k+jHHhgc5uJ2PPujb2v1yOwUp+Xmo/69zjgGDbIyd8oTy3g6AfzB7/Z/uU2V4riFX07r
	g8zVDhJOf3QieuoZMoqvLafoTB4OOJRyP0entysL/7GNE6/V6dQArtnEYqayG4AkFxp/CkXWTm0
	RHdruJtSAfaYVdmJJTfQ8qEccUbzmOHwmdXe69DgQeTNTNL/em/FB+SAH+ZyoLjPpb9
X-Google-Smtp-Source: AGHT+IGitbk1SBZ8i6I/16DXqU5ZqIa4zUYc/a94r8AU30+VoEWiOjzICaCR39+/6YAvGwaSGnJ5T1RqczQTlRLZSFw=
X-Received: by 2002:a05:6402:2714:b0:641:3a92:7e6f with SMTP id
 4fb4d7f45d1cf-645559fcb28mr14017569a12.0.1764083629776; Tue, 25 Nov 2025
 07:13:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-7-pasha.tatashin@soleen.com> <aSQU1LlPDDsN2rUw@kernel.org>
In-Reply-To: <aSQU1LlPDDsN2rUw@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 25 Nov 2025 10:13:13 -0500
X-Gm-Features: AWmQ_bmueOySR-IcM9KD_nVWlrEwNsK-bJkIQQ6vkf5Ej_a3i1HC8W4-4CGCmcA
Message-ID: <CA+CK2bAoZ9GhL+SCsrzWL-eG1XcRai0h9QMrL-fsZJFzSxSt6g@mail.gmail.com>
Subject: Re: [PATCH v7 06/22] liveupdate: luo_file: implement file systems callbacks
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 3:18=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Sat, Nov 22, 2025 at 05:23:33PM -0500, Pasha Tatashin wrote:
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
>
> With some comments below
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>
> > ---
> >  include/linux/kho/abi/luo.h      |  39 +-
> >  include/linux/liveupdate.h       |  98 ++++
> >  kernel/liveupdate/Makefile       |   1 +
> >  kernel/liveupdate/luo_file.c     | 882 +++++++++++++++++++++++++++++++
> >  kernel/liveupdate/luo_internal.h |  38 ++
> >  5 files changed, 1057 insertions(+), 1 deletion(-)
> >  create mode 100644 kernel/liveupdate/luo_file.c
> >
>
> ...
>
> > +int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd=
)
> > +{
> > +     struct liveupdate_file_op_args args =3D {0};
> > +     struct liveupdate_file_handler *fh;
> > +     struct luo_file *luo_file;
> > +     struct file *file;
> > +     int err;
> > +
> > +     if (luo_token_is_used(file_set, token))
> > +             return -EEXIST;
> > +
> > +     file =3D fget(fd);
> > +     if (!file)
> > +             return -EBADF;
> > +
> > +     err =3D luo_alloc_files_mem(file_set);
> > +     if (err)
> > +             goto  err_files_mem;
> > +
> > +     if (file_set->count =3D=3D LUO_FILE_MAX) {
>
> This can be checked before getting the file and allocating memory, can't =
it?

Moved up.

>
> > +             err =3D -ENOSPC;
> > +             goto err_files_mem;
>
> The goto label should say what it does, not what the error was.

Changed to err_free_files_mem;

>
> > +     }
> > +
> > +     err =3D -ENOENT;
> > +     luo_list_for_each_private(fh, &luo_file_handler_list, list) {
> > +             if (fh->ops->can_preserve(fh, file)) {
> > +                     err =3D 0;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     /* err is still -ENOENT if no handler was found */
> > +     if (err)
> > +             goto err_files_mem;
> > +
> > +     luo_file =3D kzalloc(sizeof(*luo_file), GFP_KERNEL);
> > +     if (!luo_file) {
> > +             err =3D -ENOMEM;
> > +             goto err_files_mem;
> > +     }
> > +
> > +     luo_file->file =3D file;
> > +     luo_file->fh =3D fh;
> > +     luo_file->token =3D token;
> > +     luo_file->retrieved =3D false;
> > +     mutex_init(&luo_file->mutex);
> > +
> > +     args.handler =3D fh;
> > +     args.file =3D file;
> > +     err =3D fh->ops->preserve(&args);
> > +     if (err)
> > +             goto err_kfree;
> > +
> > +     luo_file->serialized_data =3D args.serialized_data;
> > +     list_add_tail(&luo_file->list, &file_set->files_list);
> > +     file_set->count++;
> > +
> > +     return 0;
> > +
> > +err_kfree:
> > +     mutex_destroy(&luo_file->mutex);
>
> Don't think we need this, luo_file is freed in the next line.

Removed.

>
> > +     kfree(luo_file);
> > +err_files_mem:
> > +     fput(file);
> > +     luo_free_files_mem(file_set);
>
> I'd have the error path as
>
> err_free_luo_file:
>         kfree(luo_file);
> err_free_files_mem:
>         luo_free_files_mem(file_set);
> err_put_file:
>         fput(file);

Yeap, done like this.

>
> > +
> > +     return err;
> > +}
>
> ...
>
> > +void luo_file_unpreserve_files(struct luo_file_set *file_set)
> > +{
> > +     struct luo_file *luo_file;
> > +
> > +     while (!list_empty(&file_set->files_list)) {
>
> list_for_each_entry_safe_reverse()?

In this case I prefer while(!list_empty(...))
It emphasizes to  a reader that we are emptying the full list. _safe
is good to use when some items are removed from a list while
traversing.

>
> > +             struct liveupdate_file_op_args args =3D {0};
> > +
> > +             luo_file =3D list_last_entry(&file_set->files_list,
> > +                                        struct luo_file, list);
> > +
> > +             args.handler =3D luo_file->fh;
> > +             args.file =3D luo_file->file;
> > +             args.serialized_data =3D luo_file->serialized_data;
> > +             luo_file->fh->ops->unpreserve(&args);
> > +
> > +             list_del(&luo_file->list);
> > +             file_set->count--;
> > +
> > +             fput(luo_file->file);
> > +             mutex_destroy(&luo_file->mutex);
> > +             kfree(luo_file);
> > +     }
> > +
> > +     luo_free_files_mem(file_set);
> > +}
>
> ...
>
> > +int luo_file_finish(struct luo_file_set *file_set)
> > +{
> > +     struct list_head *files_list =3D &file_set->files_list;
> > +     struct luo_file *luo_file;
> > +     int err;
> > +
> > +     if (!file_set->count)
> > +             return 0;
> > +
> > +     list_for_each_entry(luo_file, files_list, list) {
> > +             err =3D luo_file_can_finish_one(file_set, luo_file);
> > +             if (err)
> > +                     return err;
> > +     }
> > +
> > +     while (!list_empty(&file_set->files_list)) {
>
> list_for_each_entry_safe_reverse()?

Same

>
> > +             luo_file =3D list_last_entry(&file_set->files_list,
> > +                                        struct luo_file, list);
> > +
> > +             luo_file_finish_one(file_set, luo_file);
> > +
> > +             if (luo_file->file)
> > +                     fput(luo_file->file);
> > +             list_del(&luo_file->list);
> > +             file_set->count--;
> > +             mutex_destroy(&luo_file->mutex);
> > +             kfree(luo_file);
> > +     }
> > +
>
> ...
>
> > diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_i=
nternal.h
> > index 1292ac47eef8..c8973b543d1d 100644
> > --- a/kernel/liveupdate/luo_internal.h
> > +++ b/kernel/liveupdate/luo_internal.h
> > @@ -40,6 +40,28 @@ static inline int luo_ucmd_respond(struct luo_ucmd *=
ucmd,
> >   */
> >  #define luo_restore_fail(__fmt, ...) panic(__fmt, ##__VA_ARGS__)
> >
> > +/* Mimics list_for_each_entry() but for private list head entries */
> > +#define luo_list_for_each_private(pos, head, member)                  =
       \
> > +     for (struct list_head *__iter =3D (head)->next;                  =
         \
> > +          __iter !=3D (head) &&                                       =
         \
> > +          ({ pos =3D container_of(__iter, typeof(*(pos)), member); 1; =
});      \
> > +          __iter =3D __iter->next)
>
> Ideally something like this should go to include/linux/list.h, but it can
> be done later to avoid bikeshedding about the name :)

Exactly, I am planning to propose this as a separate change for
list.h, but I suspect we will need to take care of other variants as
well, reverse, cont, safe etc.

>
> And you can reuse most of list_for_each_entry, just replace the line that
> accesses __private member:
>
> #define luo_list_for_each_private(pos, head, member)                    \
>         for (pos =3D list_first_entry(head, typeof(*pos), member);       =
 \
>              &ACCESS_PRIVATE(pos, member) !=3D head;                     =
 \
>              pos =3D list_next_entry(pos, member))
>

This does not work, because list_next_entry also accesses private,
what works is this:
#define luo_list_for_each_private(pos, head, member) \
for (pos =3D list_first_entry(head, typeof(*pos), member); \
     &ACCESS_PRIVATE(pos, member) !=3D head; \
     pos =3D list_entry(ACCESS_PRIVATE(pos, member).next, typeof(*pos), mem=
ber))

But that extra ACCESS_PRIVATE bothers me, so let's keep it as-is for
now. And solve it once in list.h, and then update the private macro.

> --
> Sincerely yours,
> Mike.

