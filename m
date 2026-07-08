Return-Path: <linux-api+bounces-6802-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UvN7I7WwTmrrSQIAu9opvQ
	(envelope-from <linux-api+bounces-6802-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 22:19:01 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E9072A27D
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 22:19:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=verbum.org header.s=fm2 header.b="ow/n4Rit";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="i zvy4di";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6802-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-api+bounces-6802-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30C01301CD11
	for <lists+linux-api@lfdr.de>; Wed,  8 Jul 2026 20:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231CA3ADBAD;
	Wed,  8 Jul 2026 20:18:59 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506233AC0F8;
	Wed,  8 Jul 2026 20:18:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541939; cv=none; b=Jsi7au5/Pgc1a4pg+B6VuFmCy5Do7O7r6dzZPvWSc4pCJOtPUHyHe1Kr79JiJOdjz6y/yibcsMVBdbyPM4zla919wQhTACXYfBe8FDJSYxXNPrpuebp0Cs9Jvz984ONeU1ua2uAUTxxETS0/FculcmjMynmSacU1F3xe8OHYfdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541939; c=relaxed/simple;
	bh=wLGhsWeNJi8zd8/PkkwZnzKfSNF/g1DdrFV0OOf9YqY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cd4pXA42AZsu2c9W/VFHEWBTMvZhq2JATQ8SfChMlQqxFxJfESXJMurST2gXDH6y9itSe2cVvR1uhxRmXP9jnxI6hppEgHcA1YD7zh78j4BS4LvE80TUTbryNo2ZYcJD7hVeVGqTi55Polad2m+NRGtg6pFXMyaYMsn6IEB7+C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org; spf=pass smtp.mailfrom=verbum.org; dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b=ow/n4Rit; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=izvy4diN; arc=none smtp.client-ip=103.168.172.149
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D654EC0088;
	Wed,  8 Jul 2026 16:18:54 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Wed, 08 Jul 2026 16:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783541934;
	 x=1783628334; bh=wLGhsWeNJi8zd8/PkkwZnzKfSNF/g1DdrFV0OOf9YqY=; b=
	ow/n4Rit5tUlEd2H3q0EG/TVdn2dzyC9g40PZAHxVjO+WA2ydZCUqPcuwfiQpSYA
	hhKT1Noiibx3cz96xPjI2Y27BGua9XfG0ZR6DKwsEdyyB8kus0twp75/VTK3+R2I
	8vkeWggo1FepJd//zs5uAQZftRuqS6so3/5TyP1yi6EMi5tFXFiuYbe4l41hoQbn
	pEhGkSEO4ogzNbO6mcyAbhhDXzfEtR4fxb1LvDGtkTyZfRMKrjtOOosWK84zN3uj
	mPzwVbTkSUp/dTR1Hmm6VXQc7i4iRkULOID8fp4QevA/ZmbfqOEZzHnjB6hjujhx
	pyJlW6/I93gxiD5UJqOpEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783541934; x=
	1783628334; bh=wLGhsWeNJi8zd8/PkkwZnzKfSNF/g1DdrFV0OOf9YqY=; b=i
	zvy4diNMr3EwaUdCBT9je5mqS3VjvyctlwpE65BoychvpB3oJDOS5DUOtLm6wG3l
	3g0Bvc1TjviPgXe0SikEnvSTcda8J+cc6iu6Xo/B4rpqvO+Vq2YISWAigBkRwfGf
	GzML+QhW+smpde/ZmnIV10Hl+vV3N/JVnI8qspZx/OqsSWXeas7KrdsFkTvKtH2Q
	UMW8cVGk5Lq0Jogxvmve/FtUk0C9cPPQfI4JIasJOSRax1ZAJnlUfhEWwzsVS9Kk
	qyyyDyEvg12ZytxZ8bTaTX5vwgJAp3+tUUJjU0hb8IKADFbk17h6+Y814M15kMtH
	6LhjgcDqntOkjdGO8tJzw==
X-ME-Sender: <xms:rLBOaicjHXAzWj2f30SgSCFtt9Gm4YwDjOXvGT1edISQp7rLKPrLdw>
    <xme:rLBOanDVf_8pC2mnRM10GE-EvyAWRa1mtsXCG3mUQqgA_hBpk2WCFo42IYiwwQJv2
    6_RnEWSOObAVF_IPlegFddN17Weq8lsOUHRTibx5pVKqVX130xUPw>
X-ME-Proxy-Cause: dmFkZTFeSPUT25v+12YVMbRBoofLsuPVc5lWVwFljbzt+zLqPXzvS4js3nW+jwmR6qiqwK
    l2E1L2sYGTAVEOpkxbHitkR4MrfePAFXCI95P8r5vW1cHnVPCapFoN0ksFkpcPxyOHmjxl
    Q3UxS3CfKznUJH9t1bb7dweAudc2NLBNNlY1Vj7KPNO2ClMqoqCcuR3Q4xEz1xXArAzlop
    kwDj1fHHL+1dmUAm7uAufaAoVr+O5SZtsPm2xR/ajf376wN043bEH0kqXoeeZ59scvJ8z9
    76XrIh3FM51EuTUDOesyqUyUYoIgl9o4yEE737hNR5K56mapr0aGMZ91aUILk06vtrnEbM
    0RztINzHEmPpqgUYqcS9DOomOKoubBzWKw/Tej5NK3ZRw+/Qxay/KC7Cim4YeHAIyeHYeo
    SojHnAD4pd0S7zm8czFFehVDgwXBww4HO3xJG/ByIkffHDjU/4QyVXLtf4jtnXgds6VAt0
    4cGcs4eHp4pB2lmSOaLKZJSLbZ7ehGHkdn4ZDvCrWghr0mc3VMmVPvaDnE8BRkBnppoF1Y
    ozs/0cHxXxVYFDU4/2Cf7Nx7NVCy5bIa+UnjdiAHpQtX1Qy8tUmwmjTxt6/KNlEqVweqYA
    aOcuqZsXiJCWmCSTvM+M0nMkPVB/LxltxZr1fjRDzZxKW5GmcgLA9ztdInPQ
X-ME-Proxy: <xmx:rLBOasGhE5DwljEjCOp92hnkDBmd-l2s62EnYPB0oOE_iQWxPvNQ1g>
    <xmx:rLBOaq3bJb6qB3C1f0R4dp8wCGR8-hAttyy99A2feNU_DGSJv5HYtA>
    <xmx:rLBOalPI9q1TWCVdIrzutQy_XXxskQqtEgURo6_NIllDFQc-Fiiuog>
    <xmx:rLBOaibrKjpkVkoCxKZnxH5gfa7tdFN4_oUrXzol3wBmef4Stjl39A>
    <xmx:rrBOalvn_VGwtfzSPnyv0ta10VqD041ZtZSW5_Gt0ZKHLVqcYuvu_Qff>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B2F56780AB5; Wed,  8 Jul 2026 16:18:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AP2jg_FR6fcw
Date: Wed, 08 Jul 2026 16:16:42 -0400
From: "Colin Walters" <walters@verbum.org>
To: "Amir Goldstein" <amir73il@gmail.com>,
 "Giuseppe Scrivano" <gscrivan@redhat.com>
Cc: "Miklos Szeredi" <miklos@szeredi.hu>,
 "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 linux-api@vger.kernel.org, "Al Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>,
 "Gao Xiang" <hsiangkao@linux.alibaba.com>,
 "linux-erofs mailing list" <linux-erofs@lists.ozlabs.org>
Message-Id: <01df945c-9dbc-4b80-b71c-f68aa70fb8bf@app.fastmail.com>
In-Reply-To: 
 <CAOQ4uxgbNhdzKN7tvRmFDpt-8CZWh9pVcMLv25HxJzA0_0WfSg@mail.gmail.com>
References: <20260708095831.3381978-1-gscrivan@redhat.com>
 <CAJfpegsJON=1_84PCGMjASYPFL=Wqsz7dnTAbO3Tdz5DfRQU+g@mail.gmail.com>
 <878q7l8y4y.fsf@redhat.com>
 <CAJfpegvQ06=2E0V_ADgxwmo7e5weTfOMozmBB-QVNLLWYAm8WQ@mail.gmail.com>
 <87wlv57dt1.fsf@redhat.com>
 <CAJfpegtTixwWSh9M-9NbwP0nUbJJ9rh0rxqO7BzgK7Su_RpM+A@mail.gmail.com>
 <87o6gh79yi.fsf@redhat.com>
 <CAOQ4uxgbNhdzKN7tvRmFDpt-8CZWh9pVcMLv25HxJzA0_0WfSg@mail.gmail.com>
Subject: Re: [PATCH] ovl: add ioctls to retrieve layer file descriptors
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.65 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[verbum.org:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:amir73il@gmail.com,m:gscrivan@redhat.com,m:miklos@szeredi.hu,m:linux-unionfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[verbum.org];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[walters@verbum.org,linux-api@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-6802-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[walters@verbum.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[verbum.org:+,messagingengine.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,app.fastmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9E9072A27D



On Wed, Jul 8, 2026, at 3:01 PM, Amir Goldstein wrote:

> If you want to keep a pool of mounted erofs images, you could do that
> in userspace -
> create a service that indexes mounted erofs images by unique mount poi=
nt paths.

You're right that it=E2=80=99d be possible to do this in user space.=20

However, overlayfs is used by many things (it=E2=80=99s a powerful =E2=80=
=9CSwiss army knife=E2=80=9D!) and this ability to reliably introspect i=
ts components is I think generally useful.

For example: https://github.com/systemd/systemd/issues/35017#issuecommen=
t-2457333218

Various tools want to know the backing filesystem(s) and/or block device=
s thereof, and if we don=E2=80=99t have something like this in the gener=
al case every overlayfs user would need to agree on a scheme to store th=
is data out of band - and manage its lifecycle as mounts change and deal=
 with where that data is stored with respect to mount namespaces etc.

Even if we had this API, would it be better to have a user space cache s=
erver for the original use case here? Maybe. I could personally go eithe=
r way.

But the introspection I think really would be generally useful and there=
 are code bases (in systemd and in composefs at least) that would start =
using it (with fallback for old kernels) for at least that use case righ=
t away.

