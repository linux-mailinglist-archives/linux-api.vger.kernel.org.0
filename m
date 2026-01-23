Return-Path: <linux-api+bounces-5737-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJz6JVb1cmm7rQAAu9opvQ
	(envelope-from <linux-api+bounces-5737-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 05:13:10 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F298770422
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 05:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E28F300B04B
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 04:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC5D38A9A7;
	Fri, 23 Jan 2026 04:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0Ptf89i"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486D728751F
	for <linux-api@vger.kernel.org>; Fri, 23 Jan 2026 04:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769141583; cv=pass; b=HNQCKzhGRlbtgQg6NFLFFZSZMOxwIYh6+An/M9GwWFgAFYYE0zYpV80+RQx7as1CGreT/4FocLgdXeJ2ub4lmjAzD66lnoAJQTSNL2FhNQa85xk2Dc8YOCzYgi+7YotsdN2LKCtvw1Nkh6mfKx1+Evcf6aC48taqg1vQ3jq0sxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769141583; c=relaxed/simple;
	bh=F1TX6MY+wTluL5db6qCSz1RHUc0piPNRg5C3FLD1mS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PF+L8jes1+EVxve1KRDxBLmFYRtwekVx0m6USD2nb/Ou9jVUe5zbwCco4QsVsRykEP3H0YkY/xCNtVfkw/MAp0f5Yps076cCqnS+ZD3TEA7ankpTQ3uTcvAJDmLXPI+ezNd0k2pfTGq0pnBf8Y4BM4VL4xji6VUK/1+WWb6Ku5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0Ptf89i; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42fed090e5fso1112560f8f.1
        for <linux-api@vger.kernel.org>; Thu, 22 Jan 2026 20:12:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769141573; cv=none;
        d=google.com; s=arc-20240605;
        b=g5kSP2LQ8AtT8ZqRdnMqciVRRT6d/mpKqhy3tBj1RKT0dO39P1pVURtz3za7K3w67E
         5ASpC7msA7Us3gH4dZ6om+RavQIMFaCQXZQ8snj4X73238VV6NS/sor+Sn7rAOu4MAS7
         D02YUK53QuuLuDPFqNO3vPIvxqIoemezJwdaP1f9GwQDAQLJ29ZK52xmCsC5uN5DWLdb
         TDYawofdu51daNsipyM08jZTRiIByNmvShcrU4NMAys/7/fLkBSEFVDGBdIzzkOE3x3r
         V9Km5ogThYmRv9To/CbZje8kG36zieSLmoPiR4fT/HAF63Mq0z69+zYsvEGQJj6xyNxq
         u2mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xoYwGgOSNtj/sexTnahA2UTTs50xESh2s02cVnq6nI4=;
        fh=oUh6xBsBGyw2F9lAEmSahozsPQuSra1FY9TdnpbNDy8=;
        b=dKVhIVlzqzNMceAYYCDeqksAmf01KbLoZXFxy8Lwt32qvjenlJ39RUuWyajjdd/bFr
         Y1J4oATaeJY1q6LG8RdZm6CBY5ZK6SFNQNGbpLyfrYMTum3qRwim1XI9m4MWTIaQ06LJ
         u/4al/yrj5C1XPGGNwJNsWv+4bMeviEkrSn5OoovSzge7GkHaRo2tSfP/jstCLobcjE7
         KWv8ievcn/2y9lKXXEK6xmw4qDKV0tJxgbfEFmKe3Kwm6DZxuIJYpcOoLhL2UIsCy/Wk
         1v98W4CNOAiQ3wUI3zbR19+V8QIEaMa5MVqfDzEMFf/Akm3MjpgzNOGJr3ah/JEn5d0J
         +rZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769141573; x=1769746373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoYwGgOSNtj/sexTnahA2UTTs50xESh2s02cVnq6nI4=;
        b=g0Ptf89ih8EdRKHS2frx3Thnt7GrkTjC/G81050h5xOoLuwZ/vSpsGaBW7bz6Hw/C0
         AtqBI48SXcG/GF582vfXjMBTq+W0bnnW+3ynP3dDPhfTYr5Yw7KUtWlwZMW8j91dHGxT
         dCvCA7BFd2UMOePhVHlXTfjbblYs/AtdPPE+5CaIbYj4Xv2q9FFsKCmonulGsUtcJd0H
         UA/OYH0zIHBR5egjTIqWszj5VRWXw7YfQu1JQlflw7Va84tnp/I8wObwXzIRuECAg0It
         nrjeoW+hb9EDi8yqXyZkxmexPkYobt0LI6t/JFuoXYLG1FfYlxU97Y30E850IhiG1AH1
         IpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769141573; x=1769746373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xoYwGgOSNtj/sexTnahA2UTTs50xESh2s02cVnq6nI4=;
        b=Qmx9YxkhveIarlBe9fj2w6AggPN02M0ZNYR8vmpW1Jh+DxseFboU6jWXvMBb1RFYyD
         COOiJshDCTLRdmCvdTZ6ysdadqpjIJk0Ze/dziluLvFuCYU7XiPgHbmWja1MDM7KCQsH
         R1QCqw2gH7ofgUbM9lq2iytoDnFyDtQcwMuoESVS1mtVHncrUBtJvHiLurBow4JkJzbU
         OFugJ7lEgkKX1Gx6uuzL3fgf6kHAm43S3X5EdpPZjfZHT+jEYa/MU1d/m7bA/9WOmVo2
         KOBl9Vrvxp74XahkrmgjJLiujHHd5gMsETqgSvRADyXJrZD77xglXidBirzK3GnROxGC
         CWwg==
X-Forwarded-Encrypted: i=1; AJvYcCVMZp+7hGPGhXZ4RQkR77r9veAtLLnm2E/NMIixM7zAv6fkqqKxy14Di3uNstvFRhWQZC+9slyyf4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT0Mc1w6HICAr2ZEkYinHUwqHArqOdARUOvsN2oPDb0dUq2iiq
	4ixRVUHIwJ2f0XqDxmWNC6hLloOj51QdpLm+PJxfLPFHLKPFuM+dW3nIYcTpivrqdWgsPfnAY7I
	0cXNDgFjH8N0XWe76iz0TsDm4wWsLouo=
X-Gm-Gg: AZuq6aK8DhprbzZP2vz6EbQIZNH6L0HzJq7NYsYLl1JqRFyS/xbSq2CAzGqzdWqVM3f
	ERrcL8cnks/4ySwW/OVCvqiMRezYFKR7fleX4pEKdrXrrfh2u0j/iRgVSsHwXpSPJVoir3O7ucf
	aNIyydSQ7IT9fXXJro8FBDXlSAZnjjltQYpr7GTizWg98lqr4scgl/ZUNZqCgoKsldTi4vUgwrL
	KyHJGd+aPhkUp+Lgzsk7N/Xlbl0jhO6ejXxEhCC5/OkCxR4LysQGGEFtkx288Dz7dciB4yODG0E
	AmAn3zhvP4AHNtFR1wTgT4eijyt67uXSFDeUeGkqqdXh+RjtN0wZOl+3wEjzbKBWAzrmk3ISlHK
	u1G8YNu9ks8qk/g==
X-Received: by 2002:a05:6000:2905:b0:435:8d02:b9cd with SMTP id
 ffacd0b85a97d-435b1593f87mr2908255f8f.26.1769141573302; Thu, 22 Jan 2026
 20:12:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123032445.125259-1-leon.hwang@linux.dev> <20260123032445.125259-3-leon.hwang@linux.dev>
 <CAADnVQJLz+nMHCZXUgy2MOxwFczEHNbG8ZUgfZeUY4yXFUKcNw@mail.gmail.com> <a0ce1dab-7d7e-4b04-a033-4f0611090d34@linux.dev>
In-Reply-To: <a0ce1dab-7d7e-4b04-a033-4f0611090d34@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Jan 2026 20:12:42 -0800
X-Gm-Features: AZwV_QiycYEsEgz0rnExs9Y8sYcjMwRBUzV5iEDcMfCB8mlQerPKQopRDo1b7WM
Message-ID: <CAADnVQ+HJkOikzE3KPhOkd1KNugs7=1dZKY1mfog-ez8noyrDA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5737-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: F298770422
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 8:07=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 23/1/26 11:55, Alexei Starovoitov wrote:
> > On Thu, Jan 22, 2026 at 7:25=E2=80=AFPM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >>
> >> +static int probe_bpf_syscall_common_attrs(int token_fd)
> >> +{
> >> +       int ret;
> >> +
> >> +       ret =3D probe_sys_bpf_ext();
> >> +       return ret > 0;
> >> +}
> >
> > When you look at the above, what thoughts come to mind?
> >
> > ... and please don't use ai for answers.
>
> My initial thought was whether probe_fd() is needed here to handle and
> close a returned fd, since the return value of probe_sys_bpf_ext() isn=E2=
=80=99t
> obvious from the call site.

Fair enough, but then collapse it into one helper if FD is a concern.
My question was about stylistic/taste preferences.

