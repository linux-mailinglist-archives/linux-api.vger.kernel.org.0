Return-Path: <linux-api+bounces-6085-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBeCNMQh3WndaAkAu9opvQ
	(envelope-from <linux-api+bounces-6085-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 13 Apr 2026 19:03:00 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D17C3F094F
	for <lists+linux-api@lfdr.de>; Mon, 13 Apr 2026 19:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E02232A4CA9
	for <lists+linux-api@lfdr.de>; Mon, 13 Apr 2026 16:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2716F30C359;
	Mon, 13 Apr 2026 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ExRQOkBb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BpqK7xTI"
X-Original-To: linux-api@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC06F22A7F0;
	Mon, 13 Apr 2026 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097741; cv=none; b=gLbQWdnsjuzaWE+M1Xu042n6GUZvAoIZ2Z+4aSDamz8VxcBABCYw+FF6P7eLIlDFK0JkKre48ZEiGMDR8T8BFddSmd1MgmFoMey1QdBvKFqHsNmw+MyCU9UIn+Vtts1rit718u5QXL8k09+c2FH1dwvprW69Nmpo4CM5BPZ2UCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097741; c=relaxed/simple;
	bh=PVKamwkfddjR39hTxmNcwgxaZYnKt5TbuFH/SCbcO1s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JKLfS25k1dPgmeWWtCS3oso+WTvl/BnsidE6Da5AVCpy+vTttDbku4D2pBD3+noyzTRaksHn9Q6pCzBfAfGnfUEQr/mMuwBo7P1hjs6W41sNRHdnGzGQjiqKJWOntJ/yecR1myVldKW4UiSJH0C7Um8UA/tYOn38zisJjXOR/M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ExRQOkBb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BpqK7xTI; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1EEC07A019D;
	Mon, 13 Apr 2026 12:28:59 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 13 Apr 2026 12:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776097738;
	 x=1776184138; bh=hZvAzDUZRm1lvdyJwjEImSU1sVV/PiwjPJrSbJaVvQE=; b=
	ExRQOkBbgb7ionSCcHduvUnoj81LTjJK0loHLklze1ALqvPDSupFk8uRbRt8iF1y
	Lwkca3A6PlH9WjEBme7CT3RhIJcNFCuNM1PH58WGgabagpCv02ghMLbwvRhsSxSH
	CoVqFGTBS5CTWtggOFwJb79AtoAMX5zocDWV27FSRWS2lfn2KLpXCAvrKcUW9bkF
	x7DbtHBGYznSkVwWHNvZvAj1LbKvfRy9hDBgacAtj2lEt1uW902Y6NUbofLJ4Lc3
	qYwPkvLOnrJnd8uJZOTW3vIEZxzjsAZWXh0+0ha1wi48Hv6dDaW3f66AW+I7V9Z3
	/GVF8YZ4vkbyCdzKVs3JFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776097738; x=
	1776184138; bh=hZvAzDUZRm1lvdyJwjEImSU1sVV/PiwjPJrSbJaVvQE=; b=B
	pqK7xTISDwOtOII1asYgzsyGTc0KS381lvET4S95kNJ30DPy/wZYK6xb4xG82bPc
	B+DerUzeZO7dJZZAVzGTz3rZQzmutxKpuvN9XUua+ktbJTAygjgGY4jagtpFEAkK
	rLbbgTpQBfynqtPm1M99SJn4UmV6ZjcSq82jyGLZ1xqiCXWZOFACkf5/OB2eaarz
	LVTsCqAPLdUeJOMf1y2XtDwWYWSC17i0NDJz5MTqazegLaBworPRDNBYjkZh+B7y
	+2pKYTTVJBQ8QiVDeF1+ax9GbJgI5NGfABS5BohIB/2AZpndKfPKhN9/0rpI5L7D
	1vOnUFnOrJ2mgT7rCM3pA==
X-ME-Sender: <xms:yhndaYM2fyMqYTJ9siACXiHkQuwrfT4aDOP4ma4gqdw3bCZRKYgzrQ>
    <xme:yhndaZy7dh5TWDjzw_3PdMlaRwhZaTdDjUHQkicj5Cjn2yFdsj6xaUaGPhB-W-PDK
    MhKLAsAjLOikGDO_6zOY6eMotMmaQCpSswdoU0X-iLgMi1c-psBpks>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhope
    gurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhifihhltgiihihnshhkihes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhr
    tghpthhtohepfigvnhiihhgrohhlihgrohesrhhutgdrvgguuhdrtghnpdhrtghpthhtoh
    eplhhinhhugidqrghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yhndabw7-De2BdlTCxKenAwbNU0Ms-sxEuz7BvbVeqeduz1GZdCe3g>
    <xmx:yhndafIpkepXf8ckQC_agoe6W2biWzDkLWl4YUv0Jmkv8rZ4EMH5Bg>
    <xmx:yhndaSVjYaLMQRWHmStn4f84HimgqBQwGVKYfXJxC323lAGOc_tDpw>
    <xmx:yhndaabf19tMZbbnaLh100TX4pfYhLmtLmKl2tHPLl1XRUIdGzrWPg>
    <xmx:yhndaW-uSW1N8kJzIdGZi3U2SQ_iyyy0DEuh_1pRJuudbB2ktNJyt6qK>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 16ACC700065; Mon, 13 Apr 2026 12:28:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AFykKnSdOGcF
Date: Mon, 13 Apr 2026 18:28:36 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Wenzhao Liao" <wenzhaoliao@ruc.edu.cn>, rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 bhelgaas@google.com,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Message-Id: <68053fb8-3305-43e0-897e-6cc4e48e2362@app.fastmail.com>
In-Reply-To: <20260406165120.166928-2-wenzhaoliao@ruc.edu.cn>
References: <cover.1775456181.git.wenzhaoliao@ruc.edu.cn>
 <20260406165120.166928-1-wenzhaoliao@ruc.edu.cn>
 <20260406165120.166928-2-wenzhaoliao@ruc.edu.cn>
Subject: Re: [RFC PATCH v3 1/6] uapi: add goldfish_address_space userspace ABI header
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6085-lists,linux-api=lfdr.de];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-api@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,arndb.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid]
X-Rspamd-Queue-Id: 2D17C3F094F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 6, 2026, at 18:51, Wenzhao Liao wrote:

> +struct goldfish_address_space_allocate_block {
> +	__u64 size;
> +	__u64 offset;
> +	__u64 phys_addr;
> +};
> +
> +struct goldfish_address_space_ping {
> +	__u64 offset;
> +	__u64 size;
> +	__u64 metadata;
> +	__u32 version;
> +	__u32 wait_fd;
> +	__u32 wait_flags;
> +	__u32 direction;
> +};
> +
> +struct goldfish_address_space_claim_shared {
> +	__u64 offset;
> +	__u64 size;
> +};

All these ioctl structures are well-formed in the sense that they
are portable across architectures and won't leak kernel data
through implicit padding.

Two of the members are a bit worrying, but that may just
be my own understanding:

- the 'phys_addr' member sounds like it refers to a physical
  memory location in the CPU address space, which in general
  should not be visible to user space, as that tends to
  expose security problems if users with access to the
  device can use this to access data they should not.

- the 'version' field may refer to the version of the ioctl
  command, which is similarly discouraged since it is
  harder to deal with than just coming up with new ioctl
  command codes. If this refers to the version of the
  remote side, this is probably fine.

> +#define GOLDFISH_ADDRESS_SPACE_IOCTL_MAGIC 'G'
> +
> +#define GOLDFISH_ADDRESS_SPACE_IOCTL_OP(OP, T) \
> +	_IOWR(GOLDFISH_ADDRESS_SPACE_IOCTL_MAGIC, OP, T)

I think it would be better to remove this intermediate macro, since
it prevents easy scraping of ioctl command codes from looking
at the source file with regular expressions.

It is also unusual that all commands are both reading
and writing the data. Please check if you can make some
of them read-only or write-only.

     Arnd

