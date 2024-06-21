Return-Path: <linux-api+bounces-1778-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B000E912074
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2024 11:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE44C1C218DD
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2024 09:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3815B16E86B;
	Fri, 21 Jun 2024 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="LPT4HTFD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fLokdyMT"
X-Original-To: linux-api@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6172916DEDA;
	Fri, 21 Jun 2024 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718961929; cv=none; b=omHHxkZg1KdYM8RUKoDH++htGt8G7Jj2QKI/IIdpADgm7ynseRp9mGBE3oCHXqizrrryEAMc0z9sY78SNMN4Nu7MIiOib0/3ps+NPK5E702LsSfgnFzXX0ocntXXF6MVFFYmOf4FX2+NpeAbgOu4IZg53wXsUVd70Li351R0Yaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718961929; c=relaxed/simple;
	bh=SIATBHynFPT4f+uIOXa3YInhK69wX4k++ZVS8wWjv5w=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=e40MiSyvzOUV550BpwAqvrSa1AxMQjauG9sUibUG0KgNdrYhwKfCUQJxndgU1MyQBxkmlWxePnmDxSwummaaHepEcpXY5m9ZJkMwftG76E89H45gZeGUML5VRssje0hvTcM5gDXcfhR6e9tpLYiu9rY+bmyXkZUJ3kEablX7uhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=LPT4HTFD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fLokdyMT; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5D05C1140227;
	Fri, 21 Jun 2024 05:25:25 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Fri, 21 Jun 2024 05:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1718961925; x=1719048325; bh=/yr39+Xu06
	R6chuqcUrLF7krLetllE+7yriX4oNGtLE=; b=LPT4HTFDM/hI9/ZaAoTIzxwKRe
	BZ9OBVXZI9UM1+VsXe9NkrCSjZW8XShs5d9s/cMSrZzxye7doyOyU13IjxhBTXwz
	UeNp7QF/tLzETXxXG0ki1Z7e6qk3irOZQPuUWpYZblME8lFM03XEL9+xG10Y7NvH
	t+Lv46QtarTCzsKwIzohso1wdo1d6zvk60L8lNgbTj8zrJizW1eEfUfQ+GDRqbYY
	BJSGH+HjEj1ChfIP3Fztuvui3BSQBgZuD2o4Dk4tF1pfN/EzMOWy6p96j8lY6RwU
	eqLMQdndw+m8frnELWO4aXlvEVBJV/kpyqUxFeyMmgm7qNoN/izyEQyDX6TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1718961925; x=1719048325; bh=/yr39+Xu06R6chuqcUrLF7krLetl
	lE+7yriX4oNGtLE=; b=fLokdyMThmaAdWVgXue8YQXjDhjjoNuzHpgVthyohscc
	AcTuggRWKhc1tNwo43gcr1IBF8VeYfhzzJNBaVEDY4icLLYUBfn/myxlXssRxxFT
	HMmA6Hdq4m+qh7sl66yy2G8it6F0VIwKwwup1VHmee/lqitWqXUXwkjL5/KjPuEB
	n8+AcyLEJkmhda60lpxpF/TxNoylg1IQoXTGmypKDXMdJuv/VSrTMkUBwD10U/d1
	1aQXl5i90prbEx/txpHaOhHSwivmvPyfMiwfQJ1mzfxE+1AvEl1UE5/PnY++z5jk
	WNSEqYkGQAPo+7b/S0QAP5BQb/F7b9KVkxP/k7E1yQ==
X-ME-Sender: <xms:BEd1ZpbmyDA35KtpPFayUxkoDb7NjX2PwggrG-51xE1E10Ioin5_eQ>
    <xme:BEd1ZgYO8zJmCBVW0Nf3O3ztoyzXO4RXIy_jg857Xw8A7asiim67Ex2iJXfe2HBYM
    lVK9iyfiOrv67yduMc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfnfhu
    khgvucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtth
    gvrhhnpedutdelgfdvgeekueeuteevffelfedukeeitedugfdvtdeutdetjeduudeuvdeg
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluh
    hkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:BEd1Zr-0_ihlzj1MovG12SIBC5Yrh1fjvFIU9206enxYuv5p-cHmHQ>
    <xmx:BEd1Znr7zdFasBTh1Q9SJAOUnFYjxaxHARyQQYRKz8mJJG8n_fdiBw>
    <xmx:BEd1ZkpzX0HSN_WvoTrsMKc73wG1JkSq2HaXcvu6uUeZRpnXXoL1Fg>
    <xmx:BEd1ZtQuV4ycGbVDHAzK3euhlZdXqggAtrKGCmVIjKuyMnVYRynGnA>
    <xmx:BUd1ZpCzBzEOjcSfKk_3ZBTqxxJbgm-eFpzPIQ6fU-J6P-IyHh77CXHl>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A549B2340082; Fri, 21 Jun 2024 05:25:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e47d7929-0977-4f2f-a894-632779ba992e@app.fastmail.com>
In-Reply-To: <a18c8b3a-90b0-47a7-aff6-a289ecddc2c0@doubly.so>
References: <20240620082223.20178-1-dev@doubly.so>
 <20240620082223.20178-2-dev@doubly.so>
 <ede8505f-bcf6-403e-bda2-6848cd4ff4c7@app.fastmail.com>
 <a18c8b3a-90b0-47a7-aff6-a289ecddc2c0@doubly.so>
Date: Fri, 21 Jun 2024 21:25:04 +1200
From: "Luke Jones" <luke@ljones.dev>
To: "Devin Bayer" <dev@doubly.so>, corentin.chary@gmail.com
Cc: "Hans de Goede" <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 1/2] platform/x86: asus-wmi: support camera disable LED
Content-Type: text/plain


On Fri, 21 Jun 2024, at 7:50 PM, Devin Bayer wrote:
> 
> Thanks for the review, Luke.
> 
> On 20/06/2024 23.40, Luke Jones wrote:
> >>   
> >> + if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_CAMERA_LED)) {
> >> + asus->camera_led.name = "platform::camera";
> > 
> > What do other devices label their camera LED as? The one I could find appears to use `<vendor>::camera`. So maybe `asus::camera` would be better? This also keeps in line with `asus::kbd_backlight`.
> 
> I reasoned it would be better to keep the name generic is so out of the 
> box desktops could toggle the camera and the LED when KEY_CAMERA is 
> pressed, just like with micmute and mute.

This might be true if one relies solely on the filesystem path, which in any case is a bad move and likely to cause the moon to drift away from earth eventually. Most Linux software will use the udev libraries available to filter devices according to any amount of criteria (and if they are not they *really should* - udev is pretty powerful and freeing.

I've tried finding prior art again and there's just not a lot to go on. ".name = "platform" shows very little except a few micmute labels. "::cam" gets one entry. So my guess is this is still a very new thing or it's not important enough to be used..

In any case looking at the rest of the possible LED entries, mostly those following keyboard, the last part of the name being sensible is what counts the most (e.g "scrolllock", "camera"). This might be setting a precedent, and if so I'd be happy with "::camera" in the LED class conveying expectations well enough.

