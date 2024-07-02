Return-Path: <linux-api+bounces-1823-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058409243DD
	for <lists+linux-api@lfdr.de>; Tue,  2 Jul 2024 18:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383871C216FD
	for <lists+linux-api@lfdr.de>; Tue,  2 Jul 2024 16:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE121C232A;
	Tue,  2 Jul 2024 16:44:56 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0C11C0DCA;
	Tue,  2 Jul 2024 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719938696; cv=none; b=m9C0Sp7sxgHP9vhZREFhcly1R6X82P5wsLq6hHwp8iHmxE0XVKQIjmR0zfS1pHFcOTt70fqXx4cxU9K2BN7ulJxebz44yEM+8et7khmHGMBqJCDWA16nkPgBerRTxRLGpcg0zWNrWkQ8IEIeOUUUW4eRXwhiSTUZpnMrjoWhQQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719938696; c=relaxed/simple;
	bh=Yhje840QSjNSdNQxsc4dG5jeAsfocmN5qaeueFJZNZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3O5m+ulHk3p/C1WdsdHO8VEH25cNXTXpY400ilu4MontiF5Kiow2c4OeDOZkRGNB6QbDeRvEhEttOcRieO2d//ZfaZm21LpRkGG1wwfZ7qJTpxGuZI/g0rXz1h/iAiXSBEWUpwTkQvA+ID1xMZq0qvG/RJY2edRWYehgbG41Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id A673472C8CC;
	Tue,  2 Jul 2024 19:44:46 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 92B507CCB3A; Tue,  2 Jul 2024 19:44:46 +0300 (IDT)
Date: Tue, 2 Jul 2024 19:44:46 +0300
From: "Dmitry V. Levin" <ldv@strace.io>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Vincent Donnefort <vdonnefort@google.com>, mhiramat@kernel.org,
	kernel-team@android.com, rdunlap@infradead.org, rppt@kernel.org,
	david@redhat.com, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v23 3/5] tracing: Allow user-space mapping of the
 ring-buffer
Message-ID: <20240702164445.GA16225@altlinux.org>
References: <20240510140435.3550353-1-vdonnefort@google.com>
 <20240510140435.3550353-4-vdonnefort@google.com>
 <20240630105322.GA17573@altlinux.org>
 <20240630084053.0b506916@rorschach.local.home>
 <9a9c8ea4-8e17-4e7e-95fe-7b51441a228c@efficios.com>
 <20240702111807.13d2dd2c@rorschach.local.home>
 <cb02f5a0-d6a3-4228-9cbb-473fd392ee48@efficios.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb02f5a0-d6a3-4228-9cbb-473fd392ee48@efficios.com>

On Tue, Jul 02, 2024 at 11:32:53AM -0400, Mathieu Desnoyers wrote:
[...]
> Note that user events also has this issue: the ioctl is not reserved in
> the ioctl-number.rst list. See include/uapi/linux/user_events.h:
> 
> #define DIAG_IOC_MAGIC '*'
> 
> /* Request to register a user_event */
> #define DIAG_IOCSREG _IOWR(DIAG_IOC_MAGIC, 0, struct user_reg *)
> 
> /* Request to delete a user_event */
> #define DIAG_IOCSDEL _IOW(DIAG_IOC_MAGIC, 1, char *)
> 
> /* Requests to unregister a user_event */
> #define DIAG_IOCSUNREG _IOW(DIAG_IOC_MAGIC, 2, struct user_unreg*)
> 
> Where '*' maps to Code 0x2A. Looking at the list I don't see any
> conflicts there, but we should definitely add it.
> 
> If we use '*' for user events already, perhaps we'd want to consider
> using the same range for the ring buffer ioctls ? Arguably one is
> about instrumentation and the other is about ring buffer interaction
> (data transport), but those are both related to tracing.

FWIW, I've checked the list of ioctls known to strace and can confirm that
currently there are no more users of 0x2a ioctl code besides these three
DIAG_* ioctls.


-- 
ldv

