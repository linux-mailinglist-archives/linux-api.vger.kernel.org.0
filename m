Return-Path: <linux-api+bounces-1817-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BBB91E1BD
	for <lists+linux-api@lfdr.de>; Mon,  1 Jul 2024 16:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3F41C2347B
	for <lists+linux-api@lfdr.de>; Mon,  1 Jul 2024 14:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCC482D9A;
	Mon,  1 Jul 2024 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fSv+muiq"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A2C14AD36;
	Mon,  1 Jul 2024 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842413; cv=none; b=es6h+zxrS5h5DHHhOs+FjyKQE/EcYknP0ItbFy/8ke9lTsv/O+ZqZ2p4DV2uzNwMOV2Bi2lnL3YB12u7sJ0x6L39bRo6TsPZSpTlBCh6/yZffJ8f2DCTlM/CJeDHziSdyIgMn2wU1FNFwyNu+KeeMaRcXz4v8Ovp68C4OVK71CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842413; c=relaxed/simple;
	bh=qTEQjVk0tKxOKX1m6lN2tYIgvkZrJ7LGYmq75GF9S9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYSoSUDJnUo1KPheDHnfvLVUqt70vwbXVjdy7ZvSMKuH3Yqjy+RPxnYuxCru0mD0JajiGYZbA8PO1+FRmYaJ/DGTcVNCrRXuxG8Mf8joxHu7aeRnVJQEQKahF3yljC86nWM36/RhWRhxIW6c4VSGqF4BaWlp9gVAoybjxahLB3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=fSv+muiq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81907C4AF0D;
	Mon,  1 Jul 2024 14:00:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fSv+muiq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1719842409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZItOz8mD+QC05vJ9N7C1vvN7W60Qy3m66+OR2/u/3EU=;
	b=fSv+muiqQJqN3a6x1gkiA6fJvKljNCDkfK5dya7Gt0NNaqUE+9a8Cpz4uC/55j3ttKFp05
	F9bza5WFJuchyRT2tGaJawPbMLflS945YXKSgg1mNBjffwxBtpQbmfkOWQS5M5nEc92GS2
	8UhqVk0+Pr2JE1sJdxCDLurUYZrOt3Q=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9e4c9795 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jul 2024 14:00:08 +0000 (UTC)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5c2284616f7so2019931eaf.1;
        Mon, 01 Jul 2024 07:00:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVSLkXkdWsAhjSs7bOLtbGAXoyj17HxNERaZXBTAfMPg2Vfp3iE/6M4GrOc3NQjIJR0M/uIyC9y5rLiLuWvaDU9T+HOCnf/W0yq19h6KxjSUbwyjZEjy1Nqisplx3VnXXJWSyhzku7QAprPBfA+PGrRkyHnKy4lKjutcqYl61PtQtUlVl6c
X-Gm-Message-State: AOJu0YzoUBUOHXB/gS6KHqS5mluPL0OxQ6BsW1jJrcmJFUl6p/Wyf+cp
	wQCTVA3hEQJRWo9U2zlheyTS/WaDtzSNFPfBRfBSJ+FpJnK7r7/phlcio6qYPMeE2ix/4hTaPMs
	w9RSXIsaLWFMtVJms8Zi8nkNuYuU=
X-Google-Smtp-Source: AGHT+IE1jxyGiueUEPSswOQsUIiXDbT8crZPdJRtiuqOnv85BhhtzLC+FOcAwhNrOHuWJUxUmx2IxcgL+w6Ca0JK8c0=
X-Received: by 2002:a05:6870:4153:b0:25d:5f08:6b0b with SMTP id
 586e51a60fabf-25db3414cfcmr5460274fac.18.1719842406764; Mon, 01 Jul 2024
 07:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620005339.1273434-1-Jason@zx2c4.com> <20240620005339.1273434-3-Jason@zx2c4.com>
 <20240620.020423-puny.wheat.mobile.arm-1wWnJHwWYyAl@cyphar.com>
 <ZnQeCRjgNXEAQjEo@zx2c4.com> <87v81txjb7.ffs@tglx> <Zn7D_YBC2SXTa_jX@zx2c4.com>
 <ZoKYoBp_bSRP_fqn@zx2c4.com>
In-Reply-To: <ZoKYoBp_bSRP_fqn@zx2c4.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 1 Jul 2024 15:59:55 +0200
X-Gmail-Original-Message-ID: <CAHmME9p-VTJnwCJK7qko_k4X=L_WqiCk9vrif=GbpJE3ZPP1PA@mail.gmail.com>
Message-ID: <CAHmME9p-VTJnwCJK7qko_k4X=L_WqiCk9vrif=GbpJE3ZPP1PA@mail.gmail.com>
Subject: Re: [PATCH v18 2/5] random: add vgetrandom_alloc() syscall
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, linux-crypto@vger.kernel.org, 
	linux-api@vger.kernel.org, x86@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, "Carlos O'Donell" <carlos@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 1:53=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.com>=
 wrote:
>
> On Fri, Jun 28, 2024 at 04:09:01PM +0200, Jason A. Donenfeld wrote:
> > fine. Also I used u32 there for the two smaller arguments, but maybe
> > that's silly and we should go straight to u64?
>
> Judging by `struct clone_args`, it looks like I've got to use
> __aligned_u64 for every argument:
>
>     struct clone_args {
>         __aligned_u64 flags;
>         __aligned_u64 pidfd;
>         __aligned_u64 child_tid;
>         __aligned_u64 parent_tid;
>         __aligned_u64 exit_signal;
>         __aligned_u64 stack;
>         __aligned_u64 stack_size;
>         __aligned_u64 tls;
>         __aligned_u64 set_tid;
>         __aligned_u64 set_tid_size;
>         __aligned_u64 cgroup;
>     };
>     #define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
>     #define CLONE_ARGS_SIZE_VER1 80 /* sizeof second published struct */
>     #define CLONE_ARGS_SIZE_VER2 88 /* sizeof third published struct */
>
> So okay, I'll do that, and will have an ARGS_SIZE_VER0 macro too.

This is now covered by v19 of this patchset:
https://lore.kernel.org/lkml/20240701135801.3698-1-Jason@zx2c4.com/

