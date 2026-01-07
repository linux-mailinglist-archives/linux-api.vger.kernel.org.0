Return-Path: <linux-api+bounces-5608-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF8ECFC2D3
	for <lists+linux-api@lfdr.de>; Wed, 07 Jan 2026 07:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23F1A301F240
	for <lists+linux-api@lfdr.de>; Wed,  7 Jan 2026 06:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113A725FA3B;
	Wed,  7 Jan 2026 06:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k22iDgLI"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3181222D7B6
	for <linux-api@vger.kernel.org>; Wed,  7 Jan 2026 06:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767766838; cv=none; b=B8VfSTRxPGloan6qlwnz/zOFtGd5rdtrQQkvYm8ILMqSI/MaMtDbUfA3qltRFpL3rKWokoEX32vDNEtiwiaS7Li3u6/9hoHvxleAomyOSPtAKu6eqi8IgOuqWdp75fktkcd2Uuk5CuJ9KxAfYfqs0mRbMcDcfzFaTx3sjJOCAlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767766838; c=relaxed/simple;
	bh=um8m+LhJ/XySx/W3cljkMVrC03SFTG9VrcE2RdgTnIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4+ehip+QJnPv6KG2h5yaRcE2vpfBL4YbD/69aBYVam3EJkcPGN5bFMyEg0Ckaq/Hgfwpa+4UdU3spdyYAekAbEItxf/kAJKKUx1MTe1CoyjyF5/qEBIr7UPZkcqCTqC98e8JiRk+XotiBSEBR2nfMmia3rpGE9E5xKCXiJdj74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k22iDgLI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so14030025e9.3
        for <linux-api@vger.kernel.org>; Tue, 06 Jan 2026 22:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767766834; x=1768371634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWHu83Rjq/t7nypMI0K/irCatIvbUqeKZDo8XoCwAbM=;
        b=k22iDgLIZKgyUN+YkwPoawizcUMqgrXnaxGh0CHhIUgXRs5ZDfLeBYgxdkZg1H6Ut+
         9kKzuU66ZblEGcXV/uPBgSIpAKkHTsu4iqSNs8zz4T/aoFKB1UI4dW7BXvuNO3mHXiNR
         MNXY4WUpkWisawFYcU5YHz69+TxjeP4HAMPKodBwelCrbq1J8KF52VXdCFcCeta/gl7s
         /vJQintNB13Js+jqDDoaodNAPOF3bsW/bNBYuU4ePMHFGuiR7zdRyhjHCog1QAsLy3o1
         0G2NkGq7Ki1KZssSsAzJyaXw6b+J/fEjtG/W00xWFxlI7G3Uqm2wCAYhHXUWFeLL7zIW
         UlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767766834; x=1768371634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cWHu83Rjq/t7nypMI0K/irCatIvbUqeKZDo8XoCwAbM=;
        b=ayZe9txWI7IfI56UdiAXzwYOcl3/hXxMvc4HXrEyFfTYbnxH0ocnOtOqYn1BBy6Yoo
         QUqIRlwsogoNOfFDnxSluF3IsAIpnFWsyw90fUOo0r9eRDXI1G2ZPrKhfrkHhOMJSVHr
         1S2iydK5TUPjDMRHUJNTOR2EIJT0JaGW+8fet8AkoMghT4+/ZFQjLT/FewP/0CSK0o2K
         kzT7sVUFuVy7RYZGhml/gfI4TTl06eVroiAmDwOorgf+d13/PoYWkrZY5oCvSHPqMc62
         oxsOPoWIZi0ea2Se0qWUrqTlJCS51hpbqtyUv0N7BDKyaxUnjM7QsIhqechujmEHuJqW
         OBTA==
X-Forwarded-Encrypted: i=1; AJvYcCWz0mEnYTxP9ro/vo2xHuVNsEgewS30eCH2VttLzClwAC2gD7ou5GfZirDNqDmOSPLtKHmq7b9j3BY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlWf9C1ko6TF7rQs5Fc5rfZQGxBSHDTy8lUTf0+0ewfyQ/U67c
	W1XKm8Wk0ZV97Ab81bOkFoRbORRp/edPLVk4jw9TQ/OEC7U3vED2vUt6UUhcX89SL5yKjHp2IrN
	6KrT3xGZBQcSj9f4DHsUzFjZ7GvjTMVc=
X-Gm-Gg: AY/fxX5YX9FuDWikmwZAJVrc1AD24UMQgSq3PCvFQFbaiXt7Ik1gha7vLxTzt3cSInn
	TbRi7/g8jVZx3uBzy+F7MdBjgcsoSQSOLb/YYPRYdgSmmqSYZDveYe95uAwzE43pAcAIhYzhZUE
	wh/ppMRbjAWHH9L289sM6D0oxBG5Ew0J4Hnu9+T+aqAoZB583mLwTLu3ms0+gc/hPN7I9qLPPgG
	t371RXWMxO6OHxMp7xHVBraQRH8EdbQmB7bP1DywQmFpfpngWwmAaGuAmN44z0TtKPevjQHWGDh
	MrMUKe8d8+rz7a7+99O9GMOPMkP0
X-Google-Smtp-Source: AGHT+IGzcWbjpFl8GHd/ugDyA2yPKFkcWyQC2ErPWaQGQburW1DXHrBAjkewP3Pay8BE6FqgUD/6VOtgPMUay58ljis=
X-Received: by 2002:a05:600c:19c9:b0:477:63db:c718 with SMTP id
 5b1f17b1804b1-47d84b18215mr13271845e9.16.1767766834354; Tue, 06 Jan 2026
 22:20:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106172018.57757-8-leon.hwang@linux.dev> <db428e27fdf0110ea05cdadf8980c7758d7f4dcd61289293394db7e34ce99601@mail.kernel.org>
 <28ace50f-9ae6-46da-a05d-eab31f33f9cb@linux.dev>
In-Reply-To: <28ace50f-9ae6-46da-a05d-eab31f33f9cb@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 Jan 2026 22:20:23 -0800
X-Gm-Features: AQt7F2pXvdZyGhsn-fNpXT8YU4CZ_7YB1R_2v3jGs3CmgaaHbblL31_h4_a6TNU
Message-ID: <CAADnVQJLifBhcpe5ci7FBB2uzTR5OXPji5RPq2NLSoVXpTfScg@mail.gmail.com>
Subject: Re: [RESEND PATCH bpf-next v4 7/9] bpf: Add common attr support for map_create
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	sforshee@kernel.org, yuichtsu@amazon.com, aalbersh@redhat.com, 
	Willem de Bruijn <willemb@google.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	Amery Hung <ameryhung@gmail.com>, Rong Tao <rongtao@cestc.cn>, 
	LKML <linux-kernel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 9:57=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
>
>
> On 7/1/26 01:44, bot+bpf-ci@kernel.org wrote:
> >> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >> index 14fc5738f2b9..e64cc7504731 100644
> >> --- a/kernel/bpf/syscall.c
> >> +++ b/kernel/bpf/syscall.c
> >
> > [ ... ]
> >
> >> @@ -6279,7 +6345,11 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t=
 uattr, unsigned int size,
> >>
> >>      switch (cmd) {
> >>      case BPF_MAP_CREATE:
> >> -            err =3D map_create(&attr, uattr);
> >> +            common_attrs.log_true_size =3D 0;
> >> +            err =3D map_create(&attr, uattr, &common_attrs);
> >> +            ret =3D copy_common_attr_log_true_size(uattr_common, size=
_common,
> >> +                                                 &common_attrs.log_tr=
ue_size);
> >> +            err =3D ret ? ret : err;
> >
> > When map_create() succeeds, it returns a file descriptor that is alread=
y
> > installed in the caller's fd table via bpf_map_new_fd(). If
> > copy_common_attr_log_true_size() then fails (e.g., user provided a
> > read-only buffer for uattr_common), the syscall returns -EFAULT but the
> > fd remains installed.
> >
> > Could this leak the file descriptor? The user gets an error and has no
> > way to know what fd number was allocated, so they cannot close it.
> >
>
> Good catch =E2=80=94 you=E2=80=99re right.
>
> If 'map_create()' succeeds and 'copy_common_attr_log_true_size()' later
> fails (e.g. returning -EFAULT), the newly created file descriptor would
> remain installed and could be leaked.
>
> I=E2=80=99ll fix this in the next revision by explicitly closing the fd w=
hen
> ret is non-zero.

No. The refactoring was wrong. Don't make the kernel do extra work.
Patch 3 introduced a bug and closing fd is not a solution.
Such a pattern can be exploited for DoS.

