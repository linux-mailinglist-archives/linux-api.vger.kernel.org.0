Return-Path: <linux-api+bounces-5345-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D3CC66C9C
	for <lists+linux-api@lfdr.de>; Tue, 18 Nov 2025 02:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6828E4E06D1
	for <lists+linux-api@lfdr.de>; Tue, 18 Nov 2025 01:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86982FF177;
	Tue, 18 Nov 2025 01:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FajRRf7o"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA432F28E2
	for <linux-api@vger.kernel.org>; Tue, 18 Nov 2025 01:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763428135; cv=none; b=NwGLQSKyTL322f9Ip3fcNC9vLue4ApTJ1BUK8xohcBTSoMRBDXzswjzXB2Uexmk+uIz9EUd7U+C+88N54vPIJS0cV0VvhDKGtpIq+IunDi28ZoMpf5X9Qbl0co4xXCBTaZX9A7XxligHQvo56xwNqVe9r6LM4zoHcwiM6GRkCEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763428135; c=relaxed/simple;
	bh=+wMjX6/AXbuiV+ac0BF8ERgzt1h6sAXTNPDP4qr0dUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5u8zf7clKGIhPYfeHT5RLAVrpt2tjkSucYFr4gTw9/caCIPyDkdXRbzqRMIfqPofry3jNzc2l++Q+f+tgbW+0RDrcRv+GQKzXPHkI+38HCnaYgQgRPBo1ogl8nFwjzA3H3up0KfT4SXjD7pVlk8sQhjs+tkvEpFtLijvZcQPhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=FajRRf7o; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6418738efa0so8547732a12.1
        for <linux-api@vger.kernel.org>; Mon, 17 Nov 2025 17:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763428132; x=1764032932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHz3ZSch0j3icwKric4qmANXVXIVVUz44Th0hsI02rw=;
        b=FajRRf7o9fmlOB0kb4b8x4Wov+chvRAXeI+UAvrddRI+7BsoFNJI0/lUxuqEKlIWlt
         JD7c5KmYtgYk5DerUey1OO4jhh/IOtz0UmQN1v2QVUBWU+x8iHa8vDFPhfs29ilxi38Q
         2E9qkLHsnNQx7P/n52/jEdhlyRsYT6qehTnVBwowU9j5YTEZfTRHsTGk9nGvRpfbLXDS
         Pg5QtSxtnOJH1Gf3OiHe5pemZ5J7WwKvIUim1PdW0WXMo9uwMQvk3QDUNneZr5+XJJAX
         mkZ1yrOoRs19zRymo/v4glj53WTVqSZFuhCUxMTZV6r8qoYGrSiLRIbYmy368w+icmd5
         LfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763428132; x=1764032932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PHz3ZSch0j3icwKric4qmANXVXIVVUz44Th0hsI02rw=;
        b=tIlBfp4whggoO2NbfUAirmoMIWCfw23mFvEYmruQ617+mvh1O/OZx7PIxpyEN2YptQ
         WHG2RMYPEJapeIG4f5OKN9xEJppanevACGYNAlQxNz+hdOQ3p9RkBzGnSiS8RCJPBB3a
         tK2Mqghc3B5RXkevGgrm3feJIlt/fN/v8+JhRuM50NoqFU4L5BUIvhf/3+4CWWAstu65
         hvP665MKtoiL79/C/EjamjotzOSi/OZtKGrQLd7OQJMepG+SM4D5WIjXb83s2EI0L74h
         AizaeDcFGO6PQz33Hq8SHsXDRg4aYzs/FuD9aGXgyxwbBTKhX+f/1oYuJfzN34CwKsuO
         qHww==
X-Forwarded-Encrypted: i=1; AJvYcCUAlXWqViJmm24RbD2rC4oUZrt/+ZqxDktLIot7zuu2RKQEk9u4GM/O9me93laPvuTGwmgpiC6OK4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywft2kv4uaqKmPVAXmOTBQSIPgl07lkUO2PeYqHCb6s7Enpk2WS
	oMW1rCi6qBVfrIxsQwzveqAVMLDM5mwf68NfcKN6O/VX7vPpkwK6PpFy6vRQdImUzmB9xPktLmy
	SWbKnCHeu6Pgdhm4ULAOTShFjjByHKhFN1HipoLPuRQ==
X-Gm-Gg: ASbGncta3nXmAXe5kCeIksvnZwUGOUVrWP0ku6Yff0+AdKjMRM2CB6OGayRnAyNeJcM
	x+cTQMkqQ6l2uPU3gwZ+Hgpa5XdN/u2m147Hda/Xm78u7LNQppD3OLn8TSBsrUuSe1QPqIDJQ6/
	UF62XmEb169rW85L6adGaN7nsDB/Gv0jKyFXelg6psdVHL/NuypRFaF6hg2hoJoc7OE0s6lOsCh
	u7lRTglfbfqnlapUF4J9QK0Ek+sD9bJVLuEOnZkagON3hWXYqqFAaVWDUCrcuHB5ywp6VPowucq
	f/g=
X-Google-Smtp-Source: AGHT+IEZfZGWJ8aSWhQVB4jEcLruJ8I9XFSeNCTF/yy15o6Dh+TeGJ/djBXr3AHvYW0X+PFfQd3I51m6KkeXZLCq7a0=
X-Received: by 2002:a05:6402:524a:b0:640:c460:8a90 with SMTP id
 4fb4d7f45d1cf-64350e06a53mr13323263a12.12.1763428132223; Mon, 17 Nov 2025
 17:08:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-19-pasha.tatashin@soleen.com> <aRu4hBPz2g-cealt@google.com>
In-Reply-To: <aRu4hBPz2g-cealt@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 17 Nov 2025 20:08:15 -0500
X-Gm-Features: AWmQ_bk93gbIXM7C6K1DzdPuJ9gaoWasB_RAHgan8OE5p-hPDMrjsz6s60y6azk
Message-ID: <CA+CK2bD2VDTP7dCaebAOVpNmhyviptRbqLegW_FhAbHkMeN-DQ@mail.gmail.com>
Subject: Re: [PATCH v6 18/20] selftests/liveupdate: Add kexec-based selftest
 for session lifecycle
To: David Matlack <dmatlack@google.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, rppt@kernel.org, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 7:06=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2025-11-15 06:34 PM, Pasha Tatashin wrote:
>
> > +/* Stage 1: Executed before the kexec reboot. */
> > +static void run_stage_1(int luo_fd)
> > +{
> > +     int session_fd;
> > +
> > +     ksft_print_msg("[STAGE 1] Starting pre-kexec setup...\n");
> > +
> > +     ksft_print_msg("[STAGE 1] Creating state file for next stage (2).=
..\n");
> > +     create_state_file(luo_fd, STATE_SESSION_NAME, STATE_MEMFD_TOKEN, =
2);
> > +
> > +     ksft_print_msg("[STAGE 1] Creating session '%s' and preserving me=
mfd...\n",
> > +                    TEST_SESSION_NAME);
> > +     session_fd =3D luo_create_session(luo_fd, TEST_SESSION_NAME);
> > +     if (session_fd < 0)
> > +             fail_exit("luo_create_session for '%s'", TEST_SESSION_NAM=
E);
> > +
> > +     if (create_and_preserve_memfd(session_fd, TEST_MEMFD_TOKEN,
> > +                                   TEST_MEMFD_DATA) < 0) {
> > +             fail_exit("create_and_preserve_memfd for token %#x",
> > +                       TEST_MEMFD_TOKEN);
> > +     }
> > +
> > +     ksft_print_msg("[STAGE 1] Executing kexec...\n");
> > +     if (system(KEXEC_SCRIPT) !=3D 0)
> > +             fail_exit("kexec script failed");
> > +     exit(EXIT_FAILURE);
>
> Can we separate the kexec from the test and allow the user/automation to
> trigger it however is appropriate for their system? The current
> do_kexec.sh script does not do any sort of graceful shutdown, and I bet
> everyone will have different ways of initiating kexec on their systems.

Yes, this is a good idea, I am going to do what you  suggested:
1. provide stage as argument.
2. allow user to do kexec command

Thank you,
Pasha

