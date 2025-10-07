Return-Path: <linux-api+bounces-5012-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F218BC02B7
	for <lists+linux-api@lfdr.de>; Tue, 07 Oct 2025 07:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED5824E122D
	for <lists+linux-api@lfdr.de>; Tue,  7 Oct 2025 05:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CEB4C6C;
	Tue,  7 Oct 2025 05:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M4nZ9erL"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2DEEACE;
	Tue,  7 Oct 2025 05:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759813727; cv=none; b=uLSGNUYB9rR6PCC1uRoR51HdV4GLchIIwJDRSidGTJiHXFrafx7TbUGI7FqmYs/ndglhTmWOiu/jb1nT+smthz3KQc3EVV1X/0vClS0sPOWQu8DDkh8FukSbIsr12NARcBVsoMPJJCFqX9k/bKpDZ7qmuPSKp/I88fRar9P49iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759813727; c=relaxed/simple;
	bh=t9pKeUFjRFIXpM36o4oBUu52/lAn3GijJo/NTUZCRXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/CjiXFnDvSLy3eeZ/mNUnRLFbTCpyOnFzl9PRnGp5Pka/GnG4uuaz67kjN+gBeHgd+BQi0pTQDfR29Of/em4yE67FPuICGUUZBEyv/HYhJPvZ0AKmGqGcYH+2aEenFnABOyXrhH9N95UPwpykx1A3sycAFXMmpm6VuWm6iA7Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M4nZ9erL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QJsox1RoyKsVxuvdiBggrwtrbSp5l8DXP2P5Uyhj6VM=; b=M4nZ9erLNqzm5OMxQtneS+Km77
	oGtC4Wpzxxuch5360H0lKFMERThgfH9ifRQAdK3E4CY+QMiW/dH837WmANtn8CnSNQWzPQnH67B2z
	mKl0Y2V9Pjd7YGjg+eUUb4dLx6qyUvP2DpI10d4ywrglao1x8dFmmTfK2YyHRJg/naBGtEqGxiK5h
	XmYnKJvwMWwUXMCccveSJD2NZ8XQfmIVq5NkXxEcF5V/jnEJ/q2QWtDcuh9tqVtbYfEjNNiaZzUS7
	cJrE/0epf/UdhxrSheCUgf3mnpiJVraaE4LNlqhLP3n5Q8fy4XDGKbpU5qAUrRoFpiE1vo2BEUGGn
	mzfoIuNA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5zwL-00000001Gu5-18D6;
	Tue, 07 Oct 2025 05:08:45 +0000
Date: Mon, 6 Oct 2025 22:08:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Christoph Hellwig <hch@infradead.org>,
	Pavel Emelyanov <xemul@scylladb.com>, linux-fsdevel@vger.kernel.org,
	"Raphael S . Carvalho" <raphaelsc@scylladb.com>,
	linux-api@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] fs: Propagate FMODE_NOCMTIME flag to user-facing
 O_NOCMTIME
Message-ID: <aOSgXXzvuq5YDj7q@infradead.org>
References: <20251003093213.52624-1-xemul@scylladb.com>
 <aOCiCkFUOBWV_1yY@infradead.org>
 <CALCETrVsD6Z42gO7S-oAbweN5OwV1OLqxztBkB58goSzccSZKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVsD6Z42gO7S-oAbweN5OwV1OLqxztBkB58goSzccSZKw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Oct 04, 2025 at 09:08:05AM -0700, Andy Lutomirski wrote:
> > Well, we'll need to look into that, including maybe non-blockin
> > timestamp updates.
> >
> 
> It's been 12 years (!), but maybe it's time to reconsider this:
> 
> https://lore.kernel.org/all/cover.1377193658.git.luto@amacapital.net/

I don't see how that is relevant here.  Also writes through shared
mmaps are problematic for so many reasons that I'm not sure we want
to encourage people to use that more.


