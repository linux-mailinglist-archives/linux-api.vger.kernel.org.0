Return-Path: <linux-api+bounces-1599-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DF48CE236
	for <lists+linux-api@lfdr.de>; Fri, 24 May 2024 10:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00BC01C2140D
	for <lists+linux-api@lfdr.de>; Fri, 24 May 2024 08:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1BF1292DD;
	Fri, 24 May 2024 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hWZIpCr6"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FB81292D0;
	Fri, 24 May 2024 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716538687; cv=none; b=MsIkkU7Y6tHWKjPmO7FsvDJFDwRVYlreCMBQP56lDFDbEWvLh+h9Q5r16EIjwInanqaJUdJt+vIUjA77+jhnPrytYomC4NE+9m0TYR5Hi3uVHNR2eyUN/JMQKb92y6Q1wFYLZKyYZ29P9NKO6/7+U+VMXXL0ZJsBXeqvQrdew/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716538687; c=relaxed/simple;
	bh=AbpBb4SoeryfpDXDfbidLfrYC8TWLUiF5wG1wSMxyjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGetKbt2TezxNZ+unI14fVlQX0yGWDlJ5v0XkZs6tsffVhChlFzsxPiq0k5STUJFnBimzaVQyQdc1uZ+ZytSxsvBxNEv39lv3AwpFqfuO0B9httvMJ1n33thRKD1SLuAE+kY88RcJSS8A8f3VpwTZuFNp7RK7zKMINVqul0jkkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hWZIpCr6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AbpBb4SoeryfpDXDfbidLfrYC8TWLUiF5wG1wSMxyjo=; b=hWZIpCr6tviREUMFWAuUp4umW9
	NZWn0004AbZVadOJsQS3lqt3L6PEWltNr1UilzcQUMAxde60wR4ht4KwMwWKoU5X0DfpJpqD8YbYG
	22HkWcjNNZMshRc+io0jryT2aa5bcQcMoFr0M6lnNbU2cINVO3JzpT1i8TPHe32l7AhObONCL5i/O
	fXhwQw8bbCU7nFFDdE/mJ4WbMcGHGA99R56TAsydb9ku8EQLv8JCy6ibtgC8eeNs0MnC7uezI8ffe
	cu+YDVT5EYwrvcF5yiKXhFeVrGs38R02hMo6WwvQn7MxsmynQAQprDu8xGaoJl2qs2rh4DsfOZTCp
	3wbExWWA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAQ7o-00000008Mbk-0faT;
	Fri, 24 May 2024 08:18:04 +0000
Date: Fri, 24 May 2024 01:18:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bastian Germann <bage@debian.org>
Cc: linux-xfs@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v2] xfs_io: make MADV_SOFT_OFFLINE conditional
Message-ID: <ZlBNPDomQpTfAmt2@infradead.org>
References: <20240522223748.9986-1-bage@debian.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522223748.9986-1-bage@debian.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +#ifdef MADV_SOFT_OFFLINE

Can you add a comment here that this is missing on mips as of Linux
6.9?

Also adding the mips maintainer so he can add it, as missing a madvise
random feature on a random architecture looks like a bug that should be
fixed.


