Return-Path: <linux-api+bounces-1660-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E7E8D624C
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2024 15:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E1A2846F1
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2024 13:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E68158A14;
	Fri, 31 May 2024 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PFpXGc5D"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D7D15884E
	for <linux-api@vger.kernel.org>; Fri, 31 May 2024 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717160472; cv=none; b=IfdkOvpYmrSnumzaWY+s25P7kRa/zX24xQOIOyC7/yagPQcznS+fJf6GbqTIuNqYupIB1ReKfCRqVAeDrp+ie6vwWhVQ1n7etwHGYi57ukeMCJ1r5EID+gxrfcIzW4CdFwhC++9yppbOq5ZidSTV5/Y3O9rw1iJzYAHbveQaoB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717160472; c=relaxed/simple;
	bh=nUsPB5Ony4aNAlYic6rvb9WueoAtsv5tUM/Q9JTEZ3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eR3Y5YEbLlRq0i1N7i2ZTdxJIl4NMlDeUs4cLG/CVIXYwVT/dsOgdXR+wb5sMp6dvlROpNtjnpaxWAtXItg3nVp19ARUbZlBRVppZBM8gPH4EGa+Y51wLZn33UJwfsNaJ1n+v0D/wEEM1vymTA1XGM9Dph8FR/9jMa6f5J0jD2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PFpXGc5D; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so14070a12.0
        for <linux-api@vger.kernel.org>; Fri, 31 May 2024 06:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717160468; x=1717765268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRchOj1ggC2TIQN8s7PjJT+YjUNxb7bVoZD51wfkss8=;
        b=PFpXGc5DGRUF9TJIreQGKIz2ymTaZ8bWe0Ih7ynPCu8MXazPSW5v0Rq6gOac8TBZ1K
         50QmqnIMo3fD5/psNkwvkQ3z40mve8bCi+2eKv+aMN2z3HrM/KC1ThLkgxsC6Mr4IYXs
         rJMoRnRIR0kc3//Iv6ygjNgffstwszYuV1JsL1yzcQy6maRzItnlkw5v2kuksZe41x36
         Uwby923hBVf9hKwpVPS4zre04bzZrbxUjTNL8ce7103Ho4n5e+c7Wmi6Pq9Gph6LDUeu
         y41B8iY7d4Xpfw/Jh8mfAMzu5qH6LrvbjrEKp8VkQWyhNoxHdowxfy0qN3XjUJQslJ+T
         fICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717160468; x=1717765268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRchOj1ggC2TIQN8s7PjJT+YjUNxb7bVoZD51wfkss8=;
        b=YW7CbNfyFIiM+xAsXalDSNDsEz8icyWwx97degOArrdFWpxhoGLcFYfwEzVeB3GoSO
         DiAXLFKLVOaLXXXyZqwrgQJvgzger2ZtCEu/9YpRi5+UI5e+yDJCjiXqU65a9+5R9f3u
         GwIho/6yy12NIi6wrzfQg0Sxc+w0ZDmb/7unKdjU2U6DiXzAS/d7e5n7i4xssaq74DeB
         wdnscnzb/XLAvX7aq6G57nFnnClDwyoLz1A0cHyYyIv+M1XC+hPF9QJH+rst6uCgnLUV
         gdyWdWteB6F8CqY31APoAUAtg3cwa68H8ozaFG1oFiuwm0K6EFYi9fU5csSA1eWqH7pQ
         FdQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGZItdNxZgnYxIbII7hwOfyoeXK169uipLPo0w4WU76HOl+TbuT067W7WA8Tw6uQ6WhA79MlIryPaOyKxoR8NBFAQfFcdyPqQK
X-Gm-Message-State: AOJu0YzQ4KPaAhZpGXlcJbUsmlB7moIq24KymhF9PG1TDUK6u4O/1MxA
	ostLAlBySkZqJnwXB0k6IRNzM2WqmE3w4CRVp2ouKzA38Rim30ax5Em+3QQ/xQjLL9TESW4toHO
	JU0Gj+0oclVnZjTvgjmY19NTm63jJcIdadOkn
X-Google-Smtp-Source: AGHT+IGyobXtF/ORS1N/GztNIrOHPwMv9FM8zg9fZE3Hz3rHQXNmWAty6aJ8lRd6Vdl/KOtZJApkG+sJ4f7FFcdpcvU=
X-Received: by 2002:a05:6402:2932:b0:57a:2eac:cd4d with SMTP id
 4fb4d7f45d1cf-57a378ff925mr106485a12.5.1717160465623; Fri, 31 May 2024
 06:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528122352.2485958-1-Jason@zx2c4.com> <20240528122352.2485958-2-Jason@zx2c4.com>
 <CAG48ez0P3EDXC0uLLPjSjx3i6qB3fcdZbL2kYyuK6fZ_nJeN5w@mail.gmail.com> <Zlm-26QuqOSpXQg7@zx2c4.com>
In-Reply-To: <Zlm-26QuqOSpXQg7@zx2c4.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 31 May 2024 15:00:26 +0200
Message-ID: <CAG48ez3VhWpJnzHHn4NAJdrsd1Ts9hs0zvHa6Pqwatu4wV63Kw@mail.gmail.com>
Subject: Re: [PATCH v16 1/5] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev, tglx@linutronix.de, 
	linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, "Carlos O'Donell" <carlos@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 2:13=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.com=
> wrote:
> On Fri, May 31, 2024 at 12:48:58PM +0200, Jann Horn wrote:
> > On Tue, May 28, 2024 at 2:24=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4=
.com> wrote:
> > > c) If there's not enough memory to service a page fault, it's not fat=
al.
> > [...]
> > > @@ -5689,6 +5689,10 @@ vm_fault_t handle_mm_fault(struct vm_area_stru=
ct *vma, unsigned long address,
> > >
> > >         lru_gen_exit_fault();
> > >
> > > +       /* If the mapping is droppable, then errors due to OOM aren't=
 fatal. */
> > > +       if (vma->vm_flags & VM_DROPPABLE)
> > > +               ret &=3D ~VM_FAULT_OOM;
> >
> > Can you remind me how this is supposed to work? If we get an OOM
> > error, and the error is not fatal, does that mean we'll just keep
> > hitting the same fault handler over and over again (until we happen to
> > have memory available again I guess)?
>
> Right, it'll just keep retrying. I agree this isn't great, which is why
> in the 2023 patchset, I had additional code to simply skip the faulting
> instruction, and then the userspace code would notice the inconsistency
> and fallback to the syscall. This worked pretty well. But it meant
> decoding the instruction and in general skipping instructions is weird,
> and that made this patchset very very contentious. Since the skipping
> behavior isn't actually required by the /security goals/ of this, I
> figured I'd just drop that. And maybe we can all revisit it together
> sometime down the line. But for now I'm hoping for something a little
> easier to swallow.

In that case, since we need to be able to populate this memory to make
forward progress, would it make sense to remove the parts of the patch
that treat the allocation as if it was allowed to silently fail (the
"__GFP_NOWARN | __GFP_NORETRY" and the "ret &=3D ~VM_FAULT_OOM")? I
think that would also simplify this a bit by making this type of
memory a little less special.

