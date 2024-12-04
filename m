Return-Path: <linux-api+bounces-2825-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D63E19E4523
	for <lists+linux-api@lfdr.de>; Wed,  4 Dec 2024 20:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D99167E71
	for <lists+linux-api@lfdr.de>; Wed,  4 Dec 2024 19:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3F71F03C9;
	Wed,  4 Dec 2024 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="gMPQYgah"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13571F03C2
	for <linux-api@vger.kernel.org>; Wed,  4 Dec 2024 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733342144; cv=none; b=Ku/RZEf7+Kw1RwS1jzhjLQv14JOZPp3zMH6kqSBfn6oIIR8YF4b2FkMYlB1Kui3n/BFQpZuYhmVapPZPuz6VmfR3FNFl9Os1Z+a+7JwqZbX4Xgm/1/k53oWOvfD74GH9XNL6/1iyjr3IdXch6ixHxNUHvLaWi7W5Mb3sNw9uzZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733342144; c=relaxed/simple;
	bh=CeOjBpeAAe/HE62wEdy3wZFXQqIvcF+KJeEvW/pHdkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbgGi7VrZKta11PBC3Ke5NqFfAvO9m50uY7pzxX6xWnVvmsd8x9xVravmTG/AlOkajK6JlN4f2wmheWGoArS5u36TaZ/FdOpu4MVQIjCRHDujxuzzvQhw7tCC6Bx/ord25B7RpBpXVp/TL9p+s8dVzgxPssdzxW4mlE9Osv5gvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=gMPQYgah; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=18XpUNT0IQJaXnPA4auNYUD5Yk/7gx4IhcNkBHdEn5Y=; t=1733342142; x=1734206142; 
	b=gMPQYgah5XEcjIuMerm20sW41AN9pvQcz+Sy5w4VsMvBQ+WJjwuWs6THN/9ngPHQn4bhYlcX3UX
	i1OAMugH4UkwUmm2s1cdOo87g7sIgn/onSDd1Cm+TcB9BMq9n3rqDXodtVCgavVxeoLX6mPB9iQ41
	Po0Zzfu89MdE2sMyfW18ddhEpqrQGR0lXO8Xstijnq0Hv0gXbFfXNajw11SnbGu6qSbyI/QeQJue7
	WzCUI2mh8H9YIFDH3jzD2ziCi3vAzmN1YCtWGJEE+uefhOFFbpKiC7v/dGME/RB+qTpeVh4RN16Cz
	neCFhnuDTNmF4JsNBulXfLuovhE3owFCmihw==;
Received: from mail-oi1-f170.google.com ([209.85.167.170]:48260)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tIvTD-0000QJ-Je; Wed, 04 Dec 2024 11:55:36 -0800
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3ea5a7a5e48so115220b6e.0;
        Wed, 04 Dec 2024 11:55:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWEMLX60Ys/UcSS5wUABLHXMSGl5KKrZ98GBeusosk+ColsZ2ruNo82eGHdpCL8HPYu71TIWTVXP6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKfNXICknPUJ0Y+Hxw0j0QvvPikG4rcPVI/WaE6F7+ri7yO0vk
	stlgOnD4M4JDrk794ctCyH4TA5DSc/zBpIucAyveB/RXTvCltxsQv5xHQbfa53yoHTlPlDbPYGs
	rNHG2y+YGrOZbx00qLRnCKZTHXOo=
X-Google-Smtp-Source: AGHT+IERmTpmkeV9y3TwKdPJYkPBPA77GwicIQKzVVsNG4qD0TfFmlSvdSlUWkMVuClVnWxMBu2Lg6gURQopRu1Jzy0=
X-Received: by 2002:a05:6808:191e:b0:3e7:9f1f:b84a with SMTP id
 5614622812f47-3eae4f87a19mr6226697b6e.21.1733342135051; Wed, 04 Dec 2024
 11:55:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111234006.5942-1-ouster@cs.stanford.edu> <20241111234006.5942-12-ouster@cs.stanford.edu>
 <07647363-622b-4023-ba71-da213754a7ae@linux.alibaba.com>
In-Reply-To: <07647363-622b-4023-ba71-da213754a7ae@linux.alibaba.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 4 Dec 2024 11:54:59 -0800
X-Gmail-Original-Message-ID: <CAGXJAmysiRx3VNDxXitPOn+yg2ck_+7fbd1XSsQQqZnwUEkvPQ@mail.gmail.com>
Message-ID: <CAGXJAmysiRx3VNDxXitPOn+yg2ck_+7fbd1XSsQQqZnwUEkvPQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 11/12] net: homa: create homa_plumbing.c homa_utils.c
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: netdev@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 5c460fe7d3aaafaf78d72307c0bc7e10

On Mon, Nov 25, 2024 at 9:32=E2=80=AFPM D. Wythe <alibuda@linux.alibaba.com=
> wrote:
> On 11/12/24 7:40 AM, John Ousterhout wrote:
> > +static struct proto homav6_prot =3D {
> > ...
> > +     .obj_size          =3D sizeof(struct homa_sock) + sizeof(struct i=
pv6_pinfo),
>
> The implementation of inet6_sk_generic() has already changed, you should =
set
> .ipv6_pinfo_offset.

Fixed.

> > +static int __init homa_load(void)
> > ...
> > +     inet_register_protosw(&homa_protosw);
> > +     inet6_register_protosw(&homav6_protosw);
>
>
> better to check the retval of inet6_register_protosw().

Fixed.

> > +out_cleanup:
> > +     homa_destroy(homa);
> > +     inet_del_protocol(&homa_protocol, IPPROTO_HOMA);
> > +     inet_unregister_protosw(&homa_protosw);
> > +     inet6_del_protocol(&homav6_protocol, IPPROTO_HOMA);
> > +     inet6_unregister_protosw(&homav6_protosw);
> > +     proto_unregister(&homa_prot);
> > +     proto_unregister(&homav6_prot);
>
>
> It's a bit strange for me that this relies on a premise: that every rever=
se operation can correctly
> identify whether the corresponding forward operation has been executed. C=
urrently, perhaps every
> function includes this capability. It's up to you, I don't insist.

Actually, not all of the cleanup functions are safe if the initializer
hasn't been invoked; good catch. I've fixed this now.

> Perhaps you can try adding MODULE_ALIAS_NET_PF_PROTO_TYPE so that the ker=
nel will automatically load
> the module when creating IPPROTO_HOMA socket. A functional suggestion, It=
's up to you.

Done; thanks for the suggestion (I wasn't aware of this feature).

> Is binding multiple times legal? For example, bind 80 first and then bind=
 8080. If not, I think
> you might need to check the inet_num.

Yes, it's legal.

> I noticed that homa_sock_init() contains a memory allocation action, perh=
aps you should add a return
> value check.

Oops; I've fixed this now.

Thanks for all the comments.

-John-

