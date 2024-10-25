Return-Path: <linux-api+bounces-2562-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855749AFA0D
	for <lists+linux-api@lfdr.de>; Fri, 25 Oct 2024 08:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43435282221
	for <lists+linux-api@lfdr.de>; Fri, 25 Oct 2024 06:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5900418DF85;
	Fri, 25 Oct 2024 06:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="BKse/37N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zh/vX6oI"
X-Original-To: linux-api@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B3E1CF96;
	Fri, 25 Oct 2024 06:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729838047; cv=none; b=fvRnftfQkirb5lvTwl/v4PevSLc/Vsh1gLHcPe9gRv2TIUyNyVRKyueY3Mir/x1I7qoOf3HEI6ngciuRUGBMRdKF571TEZTX+peGFKp0l6BCQ8dp5jwTp79eY1skn1MJIWqdSwppV8m4GZ2oC0/S64D8uMImrlo0k+Rhc7w3LaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729838047; c=relaxed/simple;
	bh=XIIXfmnQoyJ6PHBrD/Z2ly8I4qNg75d3RnafDJPd+Ac=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IbJRqkpy0EVY26NJ2yBJonPRtHUY6f/+oaxYV5zWg2f2dWPpPLKycPI4bObxXNmysHl4pjrR+V9K81cUWZDQpFFSNasCgu0RCdd27twWLt7cj0UblPvmDsz9GXpVpBa85evN56JEm/MU9YpDIfGru/AQNEj5Xmw4Ir0vhrbVtlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=BKse/37N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zh/vX6oI; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 70E9F11400F7;
	Fri, 25 Oct 2024 02:34:02 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 25 Oct 2024 02:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729838042;
	 x=1729924442; bh=Ha2Cl5VqPCOZqs6Jz3x1oIAqcm8/mvvucth4IXoKHTE=; b=
	BKse/37NGkmbZca+jq6l80daa33KvW6cxdD5V2XRp39U6yuGzN/SvzvAyThW6m+r
	fqkEbgzw2LlDn43NdvfB63VARgKqzMqN4ljmg/tPBfQdD6glL/quR89iAhlQIKzT
	iPEV2bqNhBm6FTawAHQL7sJcxMlcgUFryERrfKw4Cw5eDJZzZDkVVz5cMAFPk25f
	5IP69BSf8LO9cFxdMGGXW7GA53hsRGbccklUgdT3LsfaDHxEi849bcUB5J9Sa19y
	BMfbtbRYzfAdfKbIgg7odNHiH7n5Mia1Yqu1MX+mDVPXVnIu2vbAARQy2gbg5b/i
	AtreV2DbaAlS9aPnM2jwtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729838042; x=
	1729924442; bh=Ha2Cl5VqPCOZqs6Jz3x1oIAqcm8/mvvucth4IXoKHTE=; b=Z
	h/vX6oIJ2FpkFOu7zOKEstmZScqmXOP4B4cPAty353GKD1oNJagmrG0ng0Dnq+Ow
	jOmFA98mdhP1f+1D3TgpNaOSq4XE62f2kWFGxuhoRYxZgvlx0+mUi7qCKJVDMeWG
	J25WtjGIvZCD5kCoHPOyml4NzBUfNzcYhcL86GPg03ofMbHcbqjVP5mHYVErw24p
	TIqOdjJ8TVXnCaTtGZNBrMvMhRoWV4/7SC4yb1+Ci2tTdhtMsAEhLswKnFIvmF2I
	mGHWEZeAhppAGOQvSVlbgLcA0v3zQ1Tau750Yw18FywZfodazD0qZCduZAZ0TDS6
	9k/32DoKMXetjyr20UzPw==
X-ME-Sender: <xms:2TsbZ-iiin8B24iIFbdAxSfXVDHD50X0w8iAQzqzgY3lZCGR0o964Q>
    <xme:2TsbZ_DoOYLBCptn1_TdU8jFkOzPv4Wr6ff-O7Qwrxm9t_kSBY8hUxkO9KD1wIjD0
    difNnr073Mtda0Z97I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejuddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddv
    geejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhonhhitggrughvrghntggvud
    esghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhgvrghlmhgvihgusehighgrlhhi
    rgdrtghomhdprhgtphhtthhopehkvghrnhgvlhdquggvvhesihhgrghlihgrrdgtohhmpd
    hrtghpthhtohepughvhhgrrhhtsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohep
    phgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepthhglhigsehlih
    hnuhhtrhhonhhigidruggvpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohepuggrvhgvsehsthhgohhlrggsshdrnhgvthdprhgtphhtthhopehlih
    hnuhigqdgrphhisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2TsbZ2EmkE5qWGEhZQR1ynT67fHaiwmeZUBS77N4L1aldFvKRatY8Q>
    <xmx:2TsbZ3TpKrrPZakDpQiCBOKWVJM4gaTyoZDPISK3ayksgp11d6dyoQ>
    <xmx:2TsbZ7xiN92NS1EbNoZl9muUbdaSg9M6X5rwNLLvjqVpb52cCCGsrg>
    <xmx:2TsbZ16OgIEhTrHTxejI8NekWa4reHRVz6EkwHwQa1EKYAV8yPTJzg>
    <xmx:2jsbZzdPXQDjFt_Aj2NsDBFYtgPEAncuwfMqW1xWEreiJQlaQEe5lE1p>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A57BC2220072; Fri, 25 Oct 2024 02:34:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 25 Oct 2024 06:33:31 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Davidlohr Bueso" <dave@stgolabs.net>, "Darren Hart" <dvhart@infradead.org>,
 "Peter Zijlstra" <peterz@infradead.org>, sonicadvance1@gmail.com,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 linux-api@vger.kernel.org
Message-Id: <df8896f8-3a19-4bde-86b3-8cb1172d0de7@app.fastmail.com>
In-Reply-To: <59509fc9-1a19-4162-ac89-559e08b75c06@igalia.com>
References: <20241024145735.162090-1-andrealmeid@igalia.com>
 <20241024145735.162090-2-andrealmeid@igalia.com>
 <bde852ec-8e2f-4957-9368-00d8e5a422c4@app.fastmail.com>
 <1e62e083-f97c-4157-8d50-c3655edda97b@igalia.com>
 <59509fc9-1a19-4162-ac89-559e08b75c06@igalia.com>
Subject: Re: [PATCH RFC 1/1] futex: Create set_robust_list2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024, at 19:55, Andr=C3=A9 Almeida wrote:
> Em 24/10/2024 15:03, Andr=C3=A9 Almeida escreveu:
>> Em 24/10/2024 12:57, Arnd Bergmann escreveu:
>>> On Thu, Oct 24, 2024, at 14:57, Andr=C3=A9 Almeida wrote:
>>>> This new syscall allows to set multiple list to the same process. T=
here
>>>> are two list types: 32 and 64 bit lists.
>>> Assuming we want them to behave the same way, did you intend
>>> ROBUST_LIST_64BIT to refer to 64-bit pointers on 32-bit
>>> tasks, or should they use normal word-size pointers?
>>=20
>> Oh right, I haven't covered that indeed. I think I would need to have=20
>> something like:
>>=20
>> static void exit_robust_list_64()
>> static void exit_robust_list_32()
>>=20
>> And then each function would use explicit sizes for pointers. Also, I=20
>> would rewrite the conditions to make that every combination of 64/32b=
it=20
>> kernel/app calls the appropriated function.
>
> Something like this:
>
> #ifdef CONFIG_64BIT
> 	if (unlikely(tsk->robust_list)) {
> 		exit_robust_list_64bit(tsk, tsk->robust_list);
> 		tsk->robust_list =3D NULL;
> 	}
> #else
> 	if (unlikely(tsk->robust_list)) {
> 		exit_robust_list_32bit(tsk, tsk->robust_list);
> 		tsk->robust_list =3D NULL;
> 	}
> #endif
>
> #ifdef CONFIG_COMPAT
> 	if (unlikely(tsk->compat_robust_list)) {
> 		exit_robust_32bit(tsk, tsk->compat_robust_list);
> 		tsk->compat_robust_list =3D NULL;
> 	}
> #endif

This should work, but I wonder if it ends up simpler to
instead have tsk->robust_list64 and tsk->robust_list32
entries and just put the #ifdef CONFIG_64BIT around the code
accessing robust_list64.

     Arnd

