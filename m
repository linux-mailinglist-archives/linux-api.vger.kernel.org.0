Return-Path: <linux-api+bounces-5744-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJdmGpPDc2kCygAAu9opvQ
	(envelope-from <linux-api+bounces-5744-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 19:53:07 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9DA79C82
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 19:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD19D300443B
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 18:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD63248176;
	Fri, 23 Jan 2026 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ng9QfeUn"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7987C23182D
	for <linux-api@vger.kernel.org>; Fri, 23 Jan 2026 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194379; cv=pass; b=RB0+x91nfzAkkFkLfqQZu5DW2kL/qHMqvnCUaRcZGG/AmjgU4FJ1YwwDWuBvBCmXhQK8LpmZIHVyDSq2ZMFukYlDTYwZzZarG1uEpgYFFEkOyz9CPitxuOOQ05CU2XTlAnUZSLybpLEoviwzehyImCkfaDr9DKUR/OEdv7Nk8c8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194379; c=relaxed/simple;
	bh=z3EtqsDAY+x87WF7+9aLT4AVPsq/B/vh8YxvXKfaXBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svxLO2B97VPJl96zrPdQiCXd4skYhXaFE0HTTfcOgjf/f6I0/fdlqWbPzzsTqBnWUF4g/zNU5hYCQdQDk6/cT2WLJ+0KftUG+zNMWQYYV/ggjhbFakt4FJE7oS9Etovmbfr1LPE3LSr5zoEFrYYCUtGw4vxfWu9T/yqC0gysgFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ng9QfeUn; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-352f00d0e83so1151283a91.2
        for <linux-api@vger.kernel.org>; Fri, 23 Jan 2026 10:52:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769194378; cv=none;
        d=google.com; s=arc-20240605;
        b=hqSdEnpfx1Q0EBQAq1jU38sE3dJtMtqMxSGvq5rs7SAM+BLJJx1u5EEik20RtRoP1X
         a4oegvbY9G/p49rGZe8/KMnc2tuLG4YvKtK/PQthN/JYKQCbRjrcmPbBnLJj0yLG8Auv
         UzkhNaVamcutQm78J9csHaxKcNlfK/Wl7DAAxs+bec/NpKIolUjD6i1gHHeMM7Wn/9nR
         KN7MgppRvY/DFy2uX/pAwupAxyDqTDBCBh0pFKIbUCAFC9Flr97m2o7+/KfHrQkDY6kz
         F2Klv/B1gc9jhjasbvSrd0V8A6fdrqDZtAoqEgbVZn5n9TqJCWRqqtr2ojVppbl+VR2w
         QgtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N2X2oUhuqV8lqBjwyLuRAgoJAdlYDpctSNg1JkT30xg=;
        fh=9UuQWbTenx0feUpvsw81Bozs2iIbJN9gJdWyMl+FDGQ=;
        b=SZiLgVpVmtrbt3HxM0CwLxagTk/Pb1aHWqc8KEA1DMFS0yiNOJvGxaxjYq1Iq2OaSv
         0FYv1hxK9aYvFQpaCtNesjsBtBeo/DlyJAivxu6uxtIMAHLK7bYeHOLPIUNj3pXZPKEA
         mWpp7Knnt6oZ00zEi0m9An4+SBUOZMyV1qw/2jX8pmVWfJFwE+puPfd+X6zfQ/xD0wix
         spPBThqJq44FDQF5Gc2d+a1AQ6qJOFkWxB7/72RE4K0x9F3VRiJnIJ87mCu/rpzhP4Wp
         TJ2fKSjaANJXAiwBIKmGeuzl8+YgXPeiEs8jX1xCEkZZ1PUCevHzDat0dvq5VyFcgKW4
         fhPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769194378; x=1769799178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2X2oUhuqV8lqBjwyLuRAgoJAdlYDpctSNg1JkT30xg=;
        b=ng9QfeUnUtGWaldLldWWP1YAYQfw/50B+tT0f5EnQgvolYeZvXsswPqZFIFvoxyhgs
         ajccn5uQK00JCHA/gEy2oWicHHgGmjnOobky1VOQ52mNxDuckuoLBup3VNI/w7Sssool
         1M/uuhrRqJ+WJTfafFZn1c/LuKbPNgWbM1ywsoOw7SAFkyS2gUlZPGWAnkyVS+6336Nj
         CO3KFu6grhlsJXjmVyBiKZ+yme5DWTBvYQ05wEXaj9mYVcapeudq/GiRi78o165za5/Y
         ViBVK8PdwLNwzMlFT31FJzmc8T88uNPW1+sme46Jz7mRI53C/9wSygwtLpKSCZ7q6kaU
         TNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769194378; x=1769799178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N2X2oUhuqV8lqBjwyLuRAgoJAdlYDpctSNg1JkT30xg=;
        b=pJaKgFXE5A3B6TeWoFPj5K3PZOpO+A159fd1Jq2x2IkF2gaDq4nsrUusL01gTxoJfR
         xMEnMhXCmkHMlp+po3H7L2pr2rxmL7XYKTdb6iWUXcPXUglwwD6on4CkpVdV+4OxPFzy
         KhBPVXxyTo3NzCUcmxM/ApsN0lnx2VANd9hZr1Y/fsxe4fRxb/3FZneNYyDEyUTyMxCx
         01E+mxLVLb0JPtI0C5yVnTU4aS5Ahhstix/NMMz9tx+NCyl9HfyppTXnrTogLFfoOrVn
         rQ8xa40D1FIX69GlW6cc/ecXGCAcuzonx+YF4s2XAmTd0+Iff9OUBwKIAeA1MpjYc6Uu
         MHrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgaBIiiD6LNTd2onJGBrgOdISwScN+fUWqpzZqMoNRFI6/rDCRFrJlogRHHLXHTiLzi+tUWAvIu7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjvdIeIbJTwXKUZ5phK0wR2e+D2Oi3B0CifiESK7Jo9HACTTjT
	+XcrEN/nNurcStkz3Rw6qJbQ0/xE+Vk1Lxcow7UvZJmO1neVlYhOIo50pM178PwU6Z9a2+57Wzu
	4L8gUFquWtb2pXEAfzagGsFB3qlyRAz8=
X-Gm-Gg: AZuq6aLmdUPSaWAo6E9niMxVcMeCU1lN9PyA8I7HLtdQR3yJxbYyZ7NMthdjFNuHSI1
	OxTZOLZ/Cy6mejQFcdRIRGM7lZBVqB2E9aUHR0Pqi5TE297oSYWPXHbTNxc+AOv38aJMu+ScLZT
	xdYm6N8RW8Nz9pFt9JNNVmb+06W25Ux5hQyuY8zYC0s/GDzlkGmSAkFJbiEf7IIdurvJ+m050qw
	ZD+RDmiQDJcJv8PyfD7j8gvVvzpVtShFw5GWShs9QF+GmxK+O9bcdDpeg5aNW4FZKxskBdYizUE
	WwnKbRS+tFPl1eDu4Rc0vg==
X-Received: by 2002:a17:90b:3c05:b0:343:7714:4ca6 with SMTP id
 98e67ed59e1d1-3536894c172mr2714897a91.22.1769194377547; Fri, 23 Jan 2026
 10:52:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123032445.125259-1-leon.hwang@linux.dev> <20260123032445.125259-3-leon.hwang@linux.dev>
 <CAADnVQJLz+nMHCZXUgy2MOxwFczEHNbG8ZUgfZeUY4yXFUKcNw@mail.gmail.com>
 <a0ce1dab-7d7e-4b04-a033-4f0611090d34@linux.dev> <CAADnVQ+HJkOikzE3KPhOkd1KNugs7=1dZKY1mfog-ez8noyrDA@mail.gmail.com>
 <419976da-f296-4418-8dfe-8ad50a9f8cb5@linux.dev>
In-Reply-To: <419976da-f296-4418-8dfe-8ad50a9f8cb5@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Jan 2026 10:52:43 -0800
X-Gm-Features: AZwV_QiinsC5aYUNOHtelkljzXUfW0ud6mJXa6FtpZCanGP-V52IbcGr9qrZsWM
Message-ID: <CAEf4BzYhhf7Jd6DDr2XVf=3gKeMMmrkWW9Sr49QxuW6QudSKig@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/9] libbpf: Add support for extended bpf syscall
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, Yuichiro Tsuji <yuichtsu@amazon.com>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Tao Chen <chen.dylane@linux.dev>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Rong Tao <rongtao@cestc.cn>, LKML <linux-kernel@vger.kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5744-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D9DA79C82
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 8:19=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 23/1/26 12:12, Alexei Starovoitov wrote:
> > On Thu, Jan 22, 2026 at 8:07=E2=80=AFPM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >>
> >>
> >> On 23/1/26 11:55, Alexei Starovoitov wrote:
> >>> On Thu, Jan 22, 2026 at 7:25=E2=80=AFPM Leon Hwang <leon.hwang@linux.=
dev> wrote:
> >>>>
> >>>>
> >>>> +static int probe_bpf_syscall_common_attrs(int token_fd)
> >>>> +{
> >>>> +       int ret;
> >>>> +
> >>>> +       ret =3D probe_sys_bpf_ext();
> >>>> +       return ret > 0;
> >>>> +}
> >>>
> >>> When you look at the above, what thoughts come to mind?
> >>>
> >>> ... and please don't use ai for answers.
> >>
> >> My initial thought was whether probe_fd() is needed here to handle and
> >> close a returned fd, since the return value of probe_sys_bpf_ext() isn=
=E2=80=99t
> >> obvious from the call site.

Have you looked at how probes are called (in feat_supported()?) They
all follow the same contract: > 0 (normally just 1) means feature is
supported, 0 means feature is not supported, and <0 means something
went wrong. Libbpf will log an error and will assume feature is not
supported.

probe_sys_bpf_ext() should either follow that convention or drop the
probe_ prefix altogether to avoid confusion. And then
probe_bpf_syscall_common_attrs() is necessary only as a wrapper around
probe_sys_bpf_ext() to ignore mandatory (but unused) token_fd argument
(so to make it "pluggable" into feat_supported() framework).

So, just make probe_sys_bpf_ext() follow probe contract as described,
and then just:

static int probe_bpf_syscall_common_attr(int token_fd)
{
    return probe_sys_bpf_ext();
}

Alternatively, just make probe_sys_bpf_ext() take token_fd (but ignore
it), and just use probe_sys_bpf_ext() directly for feat_supported().


probe_fd() is not suitable here because it's for a common case when we
expect syscall to succeed and create fd, in which case that successful
fd represents successful feature detection. This is not the case here,
so probe_fd() is not what you should use.

> >
> > Fair enough, but then collapse it into one helper if FD is a concern.
> > My question was about stylistic/taste preferences.
>
> Understood, thanks for the clarification.
>
> I=E2=80=99ll rework it with the stylistic preference in mind.
>
> Thanks,
> Leon
>

