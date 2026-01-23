Return-Path: <linux-api+bounces-5735-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A9yDVXxcmlrrQAAu9opvQ
	(envelope-from <linux-api+bounces-5735-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 04:56:05 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCA770342
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 04:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32EB73007F8A
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 03:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E4937FF5C;
	Fri, 23 Jan 2026 03:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr283itV"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9FF334C09
	for <linux-api@vger.kernel.org>; Fri, 23 Jan 2026 03:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769140556; cv=pass; b=LjsyQkjXeT4HjW67fIrb9DJL0Ykot4E/2B2/oWHtzZjbYwlbIKkb29xuHojfhORZGodcVZwNTbHBeQOesTEC8t2wkhQj5p65w7g6U9532bVvGAb0pDaxC35OSIX+h5J929MBh3LoLBHmaxtKBIY77OjqIT/tJkbaOT0VwTRm4xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769140556; c=relaxed/simple;
	bh=r9jHNWMSvfTiZP6TKyMQXs/9znXBmvFyE7ShBNFhg68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLwIrVl5/Ta/OcxUbHaXTSxPpT1sZGuepGtsu/SgROQUusqM5p3URGmUDK8RY2RUUhfv+Bwh6e/hhAwNdaaT8/YehBxouyFXzdO8qlrvmpy9pQinuh+TGVBYgGg3K14aB0KCzfGNCdbJ9aTBUyX2aEB1WEQuX5NHqbKRGLsykOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wr283itV; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43591b55727so1578125f8f.3
        for <linux-api@vger.kernel.org>; Thu, 22 Jan 2026 19:55:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769140541; cv=none;
        d=google.com; s=arc-20240605;
        b=dQJtoNC+I8mRVXXlU31jTlhVZgqihp5LZilciUzRZP0TPi3mhWcOtavChh3geSiide
         bNqdYWx3V8crDypceLb353mfi15Biu4pIZNdbfEVW4ZOhJy4mGy5iTTwstMGCIqB4vno
         y0o0Ez8hwVeozsAKJeFSQmsOdqkPgBvAwCmiYrQYy4UZFICzc1IEt7ZRQeUIzyHJ3zat
         /rTHiVaadkTK/iIqGtDFN/Gy6Kdb/fm1yXK4+ghq+trOAjD584AW46r8ab8OHqCag9tg
         H8dgBh8ZWDiTm7Nktpi7VENKMcyivVdxgdve/onXoqs8U+/fgCBBbSHmy8O8JQAc6lnX
         Bl3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oLUC+i+ADen7EDXOxfQZCpoTM8xhG1CfD72IdTQT+yM=;
        fh=5Y6mfpl8Tyn4zMgsXLFmH1tWMr63vGhSGbokyfzNsgA=;
        b=ib8goHAcubMn6ko/BPZM41rGfEBlFdcWb3A6XAnrj+NUx61WiGs933jGRVgCv3PRpO
         nDT27/qRwtl/CfzD4jfvVlXm8s1IetEnCdYDXmorVegw8UEm8LA1oZ3PFmh4xfTiYDpg
         XudE4gXdZVW6R8prSGstXxMWWKiBSLAk1CW/O7BYQ7ffNcRbC6KEeouwxwx2zf5vjgty
         gVdsvkYZxxvpGFX0uGkavqZgUTjtWepdx8c2Jaof+dfmLPM/pNgfSi5c6OFAJ0HqLIVF
         QYHqS5miLj5MjLqI895o4HtyrRiHFSvYyUC4xQ9yddMkbF29KM1abplVZKKFjkCUBNpp
         HIgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769140541; x=1769745341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLUC+i+ADen7EDXOxfQZCpoTM8xhG1CfD72IdTQT+yM=;
        b=Wr283itVQA/08aWtrCdvA/5rHxNYisE4bHuEllFQE4LnL1o+9MCovBMtwrEw1sCY4g
         hcsizIuKM6VKVLrCnRsq8fKb+9o4MTonWjtmRHcX5Yd9rjS3eAJUqv3ldWQ8PNQHfrb9
         Y3tNVZTTQVDtrpnR8SxgaAoJclF+UgMDmmpqNIOOVljRDNUcIN6c70tJvLPGsgXToAl1
         4eJI8X5TfcS6qB3RNr0FdTh1IzB1RAxkiipzlUZUqkIRrs1Dvz1z4Xeda0lU1gpjkGUR
         Y6qmptXFtnLTUQkmr8fWXs+/YUndG1jsTxSVFlmzmlvWMaSDSIIGn2x77KxUtOPOm/SR
         RzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769140541; x=1769745341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oLUC+i+ADen7EDXOxfQZCpoTM8xhG1CfD72IdTQT+yM=;
        b=AIgHp6UdXtUjWQRjwo1pB5fibyLmjDbxXWEjjvgZmuV7RjHHqmDR+8vN7fDxDywzXe
         wXVofpKrWgNhKr3tWxIkc8/NL3ten3gIVDSeNxbB6xEMS7XGx0uDYom2xfxhv5LvHHFj
         u4LKD6wMXDgQZJ6iGJwxdLsMRqwTRG/zkbvWvJ5S49HKJ6uIa7/ofSptcqtOHO7Y5soH
         KogI8ZgnENOAf9T710ekiik4Xiw0PaYPrlYiYm6ZwYo+7C88Z1PQI3gYQWWyLDTmFcPN
         afIjd95NJ+iiVe5lcrNCcVMNeesTiPxTGvxvsTIv9mA6uw6hFVWrPz4T2f6YFMEg9ix4
         UG8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAAt1u1fc/g9NSVPm8grKE6SZVFhB40dOUs+q7lkgKWc4NItfYxcdIBDNFpvewhLBNZzbr1vuy0q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdTiq/wL1s5OSJc+a1QJrpXZ5fJ1lD/oK2Fm8dw5ZZzsmBmUGD
	L0WzoJ5Od9XlMNacs57NmIlcFNHOXUpmx83Y030j4Xpz8NBzWI5W6JA3ACdk62yov6XXa5ZkmsO
	Ch1op16st5cOA/Yz0xoyVV3YaWmoHvus=
X-Gm-Gg: AZuq6aL2774x76N2yvYQmcmu2w4+XXbQCX5RKjV6yIB1bYIzA77vMKXWqlMBSAgWTxW
	0PUBNLUPpxPWDSmEzjX+sdabg8Kiu8e9U39mtkP7IUoid5D056/hOPJOVz4Y4B+MI96okP5maQx
	w5/yibEnMWVaX6HnBz5ScfziQqdNV/b1dmhN3Awb2CW1+KyDiS1pG0u2wpGE6wEKZ0XnRUzu8KN
	3xHzcDUfxn0IIDODjLt+snsc+1puh0Z3zjOGvhAOcLSDtKuVx6S39UwvGwIoDj4v6NzKJrSspow
	4+Fkle/7qC95dCETjMOdrzR7KTi1MxjBipEGefkva0V3ALlJP4/D0X907dajPcw3fPl9DgjXBF7
	h0gtcvRIGZaPsXg==
X-Received: by 2002:a5d:64c5:0:b0:435:a0ca:bdc9 with SMTP id
 ffacd0b85a97d-435b161bf3cmr2680572f8f.44.1769140541425; Thu, 22 Jan 2026
 19:55:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123032445.125259-1-leon.hwang@linux.dev> <20260123032445.125259-3-leon.hwang@linux.dev>
In-Reply-To: <20260123032445.125259-3-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Jan 2026 19:55:30 -0800
X-Gm-Features: AZwV_QgqHod6Vo7nyP7nHa4qnphQWjyMdvjVdCTjYDN8Z6Yuxj1TGy-HCaBPn3c
Message-ID: <CAADnVQJLz+nMHCZXUgy2MOxwFczEHNbG8ZUgfZeUY4yXFUKcNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/9] libbpf: Add support for extended bpf syscall
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5735-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CDCA770342
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 7:25=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
> +static int probe_bpf_syscall_common_attrs(int token_fd)
> +{
> +       int ret;
> +
> +       ret =3D probe_sys_bpf_ext();
> +       return ret > 0;
> +}

When you look at the above, what thoughts come to mind?

... and please don't use ai for answers.

