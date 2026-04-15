Return-Path: <linux-api+bounces-6092-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMdLJCAL4Gn2bwAAu9opvQ
	(envelope-from <linux-api+bounces-6092-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 16 Apr 2026 00:03:12 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CADB408612
	for <lists+linux-api@lfdr.de>; Thu, 16 Apr 2026 00:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53FFE3061635
	for <lists+linux-api@lfdr.de>; Wed, 15 Apr 2026 22:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4033939B0;
	Wed, 15 Apr 2026 22:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoV9YXsY"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD70D3932FD;
	Wed, 15 Apr 2026 22:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776290548; cv=none; b=sqaLVihmJnbdyW+yTjnK1u8gg/cUU/GRkwA2de630l0h9lnZpd4qg47VWU47s9qwIvBCPjl2ZJZ1QMraYIrIjxoA8B53P5BBYw8f/l/FLg6aXkXk5sUw7yhaPUxa+TbqZE9VAn/fVohYcSrobWraDgu/4KENAwpjzzblfTIZ5jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776290548; c=relaxed/simple;
	bh=eHdW8R6LaWTSjbq77BW1DvuiaGuL6ZDV4aigbLwLhpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cm02cyO9IkTXzfCFcdy/uEqKfbccEq1ffwMnfuTu4KDeyppPmPUlHAEMa1ZgphSce/K1oqYTTQQC9W8LD2x0ewW3BFi09CsE+g95fWns9kzz/9FxZyhAXKcNWPOTonq/dJo7i37ZY/+095pXQSSd9ppKll+3SduvZD67ebKNCFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoV9YXsY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773D5C2BCB3;
	Wed, 15 Apr 2026 22:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776290548;
	bh=eHdW8R6LaWTSjbq77BW1DvuiaGuL6ZDV4aigbLwLhpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XoV9YXsYNN1CZkDb1byLNi8Jdbd5s38Km7seKFLW4DLj3vnRMIQOQsLhTidaONb7k
	 h6lA5oaxu83UbcKwfOVzsb/k+YYXaI2es+iopGc2xVDzivpEy1IRExVTOUlPviLUKx
	 LU2rshy6iMXQmvz2FxUOz5W4N6hUhSFRigxwqv7yr8ILO4n3QAJrU8uqLGDrGs4iyJ
	 tN+j/zQ2h047VuVLzhzkpoaactyEXnC0jVAlS+WhivRekSM1mXKacK4qKEg5XZFmyQ
	 +oJQIR8hkIg7IPb+BTQYL2/yLU/+owgjjQd15Si2Bo0xflVuMu1XWVbbL6Dh9dah18
	 PD0KpqchWh6qg==
Date: Wed, 15 Apr 2026 22:02:26 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Akilesh Kailash <akailash@google.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: another way to set large folio by remembering
 inode number
Message-ID: <aeAK8mFxzgMOepmZ@google.com>
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com>
 <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad_HwhzlNPUEKQi6@casper.infradead.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6092-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaegeuk@kernel.org,linux-api@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CADB408612
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/15, Matthew Wilcox wrote:
> On Wed, Apr 15, 2026 at 04:44:04PM +0000, Jaegeuk Kim wrote:
> > On 04/14, Christoph Hellwig wrote:
> > > Please add the relevant mailing lists when adding new user interfaces.
> > > 
> > > And I'm not sure hacks working around the proper large folio
> > > implementation are something that should be merged upstream.
> > 
> > Cc'ed linux-api and linux-fsdevel onto the patch thread with a proposal that
> > I'm not sure it's acceptable or not. 
> 
> You haven't sent a proposal.  This is a reply to a reply to a reply of a
> patch.  There's no justification for why f2fs is so special that it
> needs this.  What the hell is going on?  You know this is not the way to
> get code merged into Linux.

I added two ideas in that email. Have you even tried to understand?

