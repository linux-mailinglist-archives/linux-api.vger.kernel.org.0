Return-Path: <linux-api+bounces-2759-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D6A9D2AD8
	for <lists+linux-api@lfdr.de>; Tue, 19 Nov 2024 17:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E0CFB279AC
	for <lists+linux-api@lfdr.de>; Tue, 19 Nov 2024 16:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97741CDFD2;
	Tue, 19 Nov 2024 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3Enm5gSs"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1DA146A9F;
	Tue, 19 Nov 2024 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033330; cv=none; b=ajaROiEQpZCUBI5faAVNtIqgd4RMfgIvdOSmh0CBi5c4OJfELl9s8ikci9OUO/bYAXq5NGc5eK/uJUV2gHYNj6pbLlTHRHsxPSHbQKVPwG8bf+/vqMJzc7T7NOJDrzYQUBR6uDDfJfD7HfhGRGDPsz58flAOEaA7WdlpN5xSvpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033330; c=relaxed/simple;
	bh=q0lwnzu1MyEalyW02TIxHamhqE5g+l+C4qb/JxUuUGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5SbJeJooTQgKcNpEdRp9VvotQ+nmkzQcLQ+b1tJNJUjdVjnhTPqEeMQOmalMcTfYCME+zx62fS5ob59WkvmP5E/PHGML/Th0iK1jLEThjXKbQSarAP41PMSS+UpL7fPK4argJw9LnBj33n8ZKC6GkjGTTjq3Ctif76TxKWV70E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3Enm5gSs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q5I5Tfd+TSQ97R3pAX5ux88NHYxJGXlNPr7zVvLk/KI=; b=3Enm5gSsqBA/P4SpCyweTZ4htA
	lLysqfE3LkFhgmOpnCpe8+eCDiOuHk9MLAA3nmZjmSO/lFNdQyPkmnTNiTrjfV2P43/vGx+ppHG03
	XYR8tB+eXaflcL3C/0a5pBRd60NHFrsyLHbBq7vufiy1ZEmHxuDeesEWVyi0opodNIp8BeSA1Pcxn
	1aXdcYuZd61OJ1sxaO8dInuK7OweT0oZzES6UNaKvJ0M92Cc8Ctc64YbtYra9XahV6Vbozd7doHje
	NJZUe3uiHrALMJJGPYYGkknu0xWfmgg5npW3Xogapq4/tK3VG9A/0S9uK62YMWLJzytE3wxI9U5Dy
	hYUvAcCQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDQzQ-0000000D0GF-3uA5;
	Tue, 19 Nov 2024 16:22:08 +0000
Date: Tue, 19 Nov 2024 08:22:08 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH] uapi: add EROBLK
Message-ID: <Zzy7MGyTp9yw1ntQ@infradead.org>
References: <9184b5e8-7070-4395-b179-4975b2e3fbc3@p183>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9184b5e8-7070-4395-b179-4975b2e3fbc3@p183>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 19, 2024 at 06:54:52PM +0300, Alexey Dobriyan wrote:
> Block drivers and DM sometimes use EROFS to report errors. There is
> no confusion about what happens but naive error reporting code might
> pass -EROFS to strerror(3) which will print "filesystem" when clearly
> there is no filesystem anywhere, it is layer above.
> 
> Or in other words, if EROFS exists, why not EROBLK?
> It is not like there is a tax on errno values.

And where would you return this value without breaking existing
userspace?

