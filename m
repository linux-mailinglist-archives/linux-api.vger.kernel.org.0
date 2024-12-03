Return-Path: <linux-api+bounces-2813-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CB99E10F5
	for <lists+linux-api@lfdr.de>; Tue,  3 Dec 2024 02:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8709282B1B
	for <lists+linux-api@lfdr.de>; Tue,  3 Dec 2024 01:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEB42E400;
	Tue,  3 Dec 2024 01:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VFHMldBB"
X-Original-To: linux-api@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724D417555;
	Tue,  3 Dec 2024 01:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733190730; cv=none; b=mox8c8X1ZYx6fEm6Fb0GP4/ym6Lni4z1p1yyjiuS27NT6GgKeYwDOHHjXGhLGaEBu8OX+nt+95LXKoVOTm5ZPyDrrypLDpCyj56IodZcDEl5jhWSO0A/Y1i2GBrfYsRwxxJy2CarLnDjI40xbeBnLDg8LrEsn/7RttvqwJ/6y7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733190730; c=relaxed/simple;
	bh=ttrUHq61GUsLEPjR2x76C3Cb2Ix+8lD/0yp8aKQeAkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBv5V14OhLEfiYb1dunrWrCMduc1V68HxIZpOjm3uiFfcabI4MoY6TjzXhnuqn8E3kznBVpfHGHCf1EFlZRXtcPtPuwmRihcqh/bkdOQvDonODh2a/bBPZj7IqfxzkOSb39gbwTF4ADk1tSCUguyOvJYRaKPqtZBN9REaTosUt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VFHMldBB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wZymErRIR67XmfdHJVBfreZmsh3d8mqQIfueM2IxZSY=; b=VFHMldBB6xg+I43HGQM/TuiutE
	1mQxFFKckFWneY1/r9bCnAzx29TD20ek9g9I8ex4EwDcuBfIwEZ9rg+gZs41R/NRLqhxcq+VmOj7f
	AE3QKznhYNDvOE1VFE3qNsB6EfKERjxXliv8Ut0cwB4owbh1S1Blk5mmvGCKfIC2gWHE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tII51-00F1HL-5s; Tue, 03 Dec 2024 02:51:59 +0100
Date: Tue, 3 Dec 2024 02:51:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH net-next v2 11/12] net: homa: create homa_plumbing.c
 homa_utils.c
Message-ID: <fd5cf76f-48c3-4d73-9609-c13ccb622382@lunn.ch>
References: <20241111234006.5942-1-ouster@cs.stanford.edu>
 <20241111234006.5942-12-ouster@cs.stanford.edu>
 <f79a70fd-35a4-4d0d-b239-daa4ab652880@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f79a70fd-35a4-4d0d-b239-daa4ab652880@linux.alibaba.com>

On Mon, Dec 02, 2024 at 11:51:48AM +0800, D. Wythe wrote:
> > +/**
> > + * homa_setsockopt() - Implements the getsockopt system call for Homa sockets.
> > + * @sk:      Socket on which the system call was invoked.
> > + * @level:   Level at which the operation should be handled; will always
> > + *           be IPPROTO_HOMA.
> > + * @optname: Identifies a particular setsockopt operation.
> > + * @optval:  Address in user space of information about the option.
> > + * @optlen:  Number of bytes of data at @optval.
> > + * Return:   0 on success, otherwise a negative errno.
> > + */
> > +int homa_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
> > +		    unsigned int optlen)
> > +{
> > +	struct homa_sock *hsk = homa_sk(sk);
> > +	struct homa_set_buf_args args;
> > +	int ret;
> > +
> > +	if (level != IPPROTO_HOMA || optname != SO_HOMA_SET_BUF ||
> > +	    optlen != sizeof(struct homa_set_buf_args))
> > +		return -EINVAL;
> 
> SO_HOMA_SET_BUF is a bit odd here, maybe HOMA_RCVBUF ? which also can be
> implemented in getsockopt.

Please trim the text when replying to just the needed context. With
pages and pages of useless quoted text it is easy to overlook your
comments.

	Andrew

