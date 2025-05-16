Return-Path: <linux-api+bounces-3779-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03687AB9E86
	for <lists+linux-api@lfdr.de>; Fri, 16 May 2025 16:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7803A86F0
	for <lists+linux-api@lfdr.de>; Fri, 16 May 2025 14:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475C4139579;
	Fri, 16 May 2025 14:20:54 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ABE2AE6F
	for <linux-api@vger.kernel.org>; Fri, 16 May 2025 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747405254; cv=none; b=S1/ngFL9UgzXHNhllJi3HGnzJew+KkHqAwqGAVxycaAr7dkACcDwiMn3L8LwjcYbWLNcCc7kjcTdkGD7XCg/xgX5s8nx66mwqKQQuyvDSsSommHwUEUtzpeAJsVE9GtRUgAFOFodfh7u37ziHDFojibnJhct71Lq6I0VFpcxcKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747405254; c=relaxed/simple;
	bh=qlyRcbfx3AUnA02GPrwtW/A/90p+kkWt/OJuUZbMQ84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6DIt4V8he2Fnc4BF2blVZs/7NGUpEh4I29g/ilCL8U5q2Wqm3bHjGOkI/T5ESlS0hQgmNMp3v+vIuc7Z3XxQY7+j0j39341xZ6t1fojesNw7IaYci7mA10udTEJJLoUX3yX3Pop/0g5nvjXcyVIeLBYbFcbXjvsxwLf6gTEqg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-151.bstnma.fios.verizon.net [173.48.112.151])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54GEKPdF009602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 10:20:25 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id E6D932E00DD; Fri, 16 May 2025 10:20:24 -0400 (EDT)
Date: Fri, 16 May 2025 10:20:24 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Rich Felker <dalias@libc.org>
Cc: Alejandro Colomar <alx@kernel.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <20250516142024.GA21503@mit.edu>
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
 <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516130547.GV1509@brightrain.aerifal.cx>

On Fri, May 16, 2025 at 09:05:47AM -0400, Rich Felker wrote:
 
> In general, raw kernel interfaces do not conform to any version of
> POSIX; they're just a low-impedance-mismatch set of inferfaces that
> facilitate implementing POSIX at the userspace libc layer. So I don't
> think this should be documented as "Linux doesn't conform" but
> (hopefully, once glibc fixes this) "old versions of glibc did not
> conform".

If glibc maintainers want to deal with breaking userspace, then as a
kernel developer, I'm happy to let them deal with the
angry/disappointed users and application programmers.  :-)

						- Ted

