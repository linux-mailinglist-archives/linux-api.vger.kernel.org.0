Return-Path: <linux-api+bounces-2278-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 020439687F1
	for <lists+linux-api@lfdr.de>; Mon,  2 Sep 2024 14:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90DE6B24E51
	for <lists+linux-api@lfdr.de>; Mon,  2 Sep 2024 12:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B7F185939;
	Mon,  2 Sep 2024 12:51:35 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA35813CFB7
	for <linux-api@vger.kernel.org>; Mon,  2 Sep 2024 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281495; cv=none; b=aE41SRUbjqY/9O44tPqPEKb0k9kM7C0Xm9S7Tzr1rRK+pUqkiD8M6MnOoyN4Qf5oGZuFI8CNoyjSg2G5MocX19/vYmxNMP4E/z0qVL4t4VHuHgzKKZwyY4wUc853O6A86ummrM9X5CrmhAXzo6nxoQiwStd7MW5vuRGCvz47Bpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281495; c=relaxed/simple;
	bh=yYYDA6rj5JUGzuvIPMJjlce3l0+qAHTEiR0Tt7xwe/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+N7TN7A8Iohso7avPZVcEMLQRwTGGOEiOni95KHqi6SU41WFODCesD/hOcQgwj+lmOOP/LeCTqGtXYK7vcUqlfEt2GDPUFtRvxKOW7ntzDXPwUVy/OqZswiAuh3VuX9aMozJ/3pVv4noHkxDe3YRDUefCDOsYCFrT5s/+Afbyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=aerifal.cx; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerifal.cx
Date: Mon, 2 Sep 2024 08:51:26 -0400
From: Rich Felker <dalias@libc.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: "H.J. Lu" <hjl.tools@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-api@vger.kernel.org, libc-alpha@sourceware.org,
	musl@lists.openwall.com
Subject: Re: [musl] AT_MINSIGSTKSZ mismatched interpretation kernel vs libc
Message-ID: <20240902125125.GS10433@brightrain.aerifal.cx>
References: <20240829205436.GA14562@brightrain.aerifal.cx>
 <20240831092902.GA2724612@port70.net>
 <20240831150241.GP10433@brightrain.aerifal.cx>
 <CAMe9rOqSSX_YP7dq5WK7vDyrQ5RP6nUNrim-8FjJi1X_8NfAvg@mail.gmail.com>
 <20240831154101.GN32249@brightrain.aerifal.cx>
 <87v7zetg1j.fsf@oldenburg3.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7zetg1j.fsf@oldenburg3.str.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Sep 02, 2024 at 02:07:36PM +0200, Florian Weimer wrote:
> * Rich Felker:
> 
> > This is ambiguously worded (does "operating system" mean kernel?) and
> > does not agree with POSIX, which defines it as:
> >
> >     Minimum stack size for a signal handler.
> >
> > And otherwise just specifies that sigaltstack shall fail if given a
> > smaller size.
> >
> > The POSIX definition is also underspecified but it's clear that it
> > should be possible to execute at least a do-nothing signal handler
> > (like one which immediately returns and whose sole purpose is to
> > induce EINTR when intalled without SA_RESTART), or even a minimal one
> > that does something like storing to a global variable, with such a
> > small stack. Allowing a size where even a do-nothing signal handler
> > results in a memory-clobbering overflow or access fault seems
> > non-conforming to me.
> 
> POSIX does not specify what happens on a stack overflow (or more
> generally, if most resource limits are exceeded), so I think the
> behavior is conforming on a technicality.

It doesn't specify what happens on overflow. It does specify what
happens on non-overflow: the program executes correctly. Failure to do
that is the problem here, not failure to trap on fault.

Rich

