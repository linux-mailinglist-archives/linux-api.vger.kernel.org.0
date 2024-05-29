Return-Path: <linux-api+bounces-1651-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD058D3230
	for <lists+linux-api@lfdr.de>; Wed, 29 May 2024 10:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009921F25219
	for <lists+linux-api@lfdr.de>; Wed, 29 May 2024 08:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9657C16A378;
	Wed, 29 May 2024 08:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wM/l0B3G"
X-Original-To: linux-api@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6607317C;
	Wed, 29 May 2024 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972289; cv=none; b=nXQnVxGUuXxwKby4yimlN4XW2K88dUAgkJKndW8t+W42owqdolVX+Ok2F3qbS4/jRyljR6CAYRH1QGVNyP6mnONrOtJkId+7w9urvc+6hI1CCqkLmWerdHDMAd5zKnEs5f1BuWioYiZdJcqDKi0IT8N/1tXnmZJXn/5cuR1od70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972289; c=relaxed/simple;
	bh=p40R5rFJGFDAQSsnFPDn0qgqt17MKj0Zb5AYtUv3X2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJ9R/8u4vrAKCkol6IP9TgcHDD2oP9QuzmMf6LmRZXMIk9BcMi+5nOd8bkXC/Bah+dsGT572oQ446dkKNczD0jB0+52RqXJS77ZkO5QnCGWf4iht4iDV1hAtGAlGwx93XUusIfM6ojJImKITCRgrV4N5seZohXfRtCH6NZHlQkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wM/l0B3G; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=62oeTUGKeiIeJZhLIw+3DjXFUnHZq5HaX9rMmbYUNjs=; b=wM/l0B3Gqohrf4/WBPLwOHYBPV
	VVtxZBJd5JpArAHR1T1gdmXT+hHz+Aa4CbDrZyrSL2Gp8EbU5k1Wc125/r20L3kyEBTIrtjEhCoNf
	KregjsT3qPc+EWoPFsgfq0YSRiPb3GODpxRa+AmIo6PZwSsgmCinvgOJck+M4i1jp9dWV+FDD6A2V
	qIpOjrgiPidNsI0X/kOtIJV72uAxlOpbc2o9S6eNEneMTWGsPBIFHq+AJVxYGZW0R4HJbnjRCcz6N
	iLM88fO8OhKwCM2mxkAizwE3e3xJ+7nM5AeLl11g2PYH1gk5rnz+7BG1otskeBZo1MscciwMOoz98
	UeKfmVLQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sCEvL-002Ic4-0r;
	Wed, 29 May 2024 08:44:43 +0000
Date: Wed, 29 May 2024 09:44:43 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexey Gladkov <legion@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, kbd@lists.linux.dev,
	linux-api@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-serial@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v5 1/3] VT: Use macros to define ioctls
Message-ID: <20240529084443.GO2118490@ZenIV>
References: <cover.1712080158.git.legion@kernel.org>
 <cover.1713375378.git.legion@kernel.org>
 <e4229fe2933a003341e338b558ab1ea8b63a51f6.1713375378.git.legion@kernel.org>
 <2024041836-most-ablaze-f417@gregkh>
 <0da9785e-ba44-4718-9d08-4e96c1ba7ab2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0da9785e-ba44-4718-9d08-4e96c1ba7ab2@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, May 29, 2024 at 09:29:23AM +0200, Jiri Slaby wrote:
> On 18. 04. 24, 8:18, Greg Kroah-Hartman wrote:
> > On Wed, Apr 17, 2024 at 07:37:35PM +0200, Alexey Gladkov wrote:
> > > All other headers use _IOC() macros to describe ioctls for a long time
> > > now. This header is stuck in the last century.
> > > 
> > > Simply use the _IO() macro. No other changes.
> > > 
> > > Signed-off-by: Alexey Gladkov <legion@kernel.org>
> > > ---
> > >   include/uapi/linux/kd.h | 96 +++++++++++++++++++++--------------------
> > >   1 file changed, 49 insertions(+), 47 deletions(-)
> > 
> > This is a nice cleanup, thanks for doing it, I'll just take this one
> > change now if you don't object.
> 
> Unfortunately, _IOC_NONE is 1 on some archs as noted by Arnd, and this
> commit changed the kd ioctl values in there which broke stuff as noted by
> Al.
> 
> We either:
> * use _IOC(0, X, Y) in here, instead of _IO(X, Y), or
> * define KDIOC(X) as _IOC(0, KD_IOCTL_BASE, X), or
> * revert the commit which landed to -rc1 already.

Revert, IMO.  If nothing else, _IO... macros are there to
	* document the copyin/copyout direction
	* make sure that argument size mismatches between the kernel
and userland get caught

Turning 16bit hex constants into that won't serve any purpose other
than preventing such patches in the future; adding a comment would
deal with that just fine.

BTW, the original odd choice for _IOC_NONE appears to have been motivated
by avoiding conflicts with legacy ioctl numbers: in CSRG repo there's
this:
commit 02cbc6a653b48bb4ec6052cbe6b3979530011c46
Author: Sam Leffler <sam@ucbvax.Berkeley.EDU>
Date:   Mon Aug 2 02:22:17 1982 -0800

    new ioctl's

...

+/*
+ * Ioctl's have the command encoded in the lower word,
+ * and the size of any in or out parameters in the upper
+ * word.  The high 2 bits of the upper word are used
+ * to encode the in/out status of the parameter; for now
+ * we restrict parameters to at most 128 bytes.
+ */
+#define        IOCPARM_MASK    0x7f            /* parameters must be < 128 bytes */
+#define        IOC_VOID        0x20000000      /* no parameters */
+#define        IOC_OUT         0x40000000      /* copy out parameters */
+#define        IOC_IN          0x80000000      /* copy in parameters */
+#define        IOC_INOUT       (IOC_IN|IOC_OUT)
+/* the 0x20000000 is so we can distinguish new ioctl's from old */
+#define        _IO(x,y)        (IOC_VOID|('x'<<8)|y)
+#define        _IOR(x,y,t)     (IOC_OUT|((sizeof(t)&IOCPARM_MASK)<<16)|('x'<<8)|y)
+#define        _IOW(x,y,t)     (IOC_IN|((sizeof(t)&IOCPARM_MASK)<<16)|('x'<<8)|y)
+/* this should be _IORW, but stdio got there first */
+#define        _IOWR(x,y,t)    (IOC_INOUT|((sizeof(t)&IOCPARM_MASK)<<16)|('x'<<8)|y)

FWIW, the upper limit on parameter size went up from 128 bytes to 8Kb in

commit 856ed9ecd2795280feed42baf3889ac7c7f9a26d
Author: Mike Karels <karels@ucbvax.Berkeley.EDU>
Date:   Thu Feb 19 22:16:28 1987 -0800

    larger ioctl's (for disklabels)

Wonder what got us (in sparc port?) to lift it from 8Kb to 16Kb...
In our historical tree that has happened in
commit 1c29224f169362b671a4bef4cd864464ef810d42
Author: Pete Zaitcev <zaitcev@redhat.com>
Date:   Sun Mar 2 08:45:12 2003 -0800

    [SPARC32/64]: Expand ioctl size field in backwards-compatible way.

No explanations there...

