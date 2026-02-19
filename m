Return-Path: <linux-api+bounces-5864-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMa5HCENl2mTuAIAu9opvQ
	(envelope-from <linux-api+bounces-5864-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 19 Feb 2026 14:16:17 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEDD15EF63
	for <lists+linux-api@lfdr.de>; Thu, 19 Feb 2026 14:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5B72300C27D
	for <lists+linux-api@lfdr.de>; Thu, 19 Feb 2026 13:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFFA1E9919;
	Thu, 19 Feb 2026 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="QMseGHyh"
X-Original-To: linux-api@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770583009DE
	for <linux-api@vger.kernel.org>; Thu, 19 Feb 2026 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771506974; cv=none; b=Mn+OgfPCPcBswv38cu+ujZJTjiGlLzRy3n1qeu5mETIkOZ7RRwWAwrKyxisEWKsgjYzbCQbb3GLs3YcnmB+eyOwcTaquROEFKNsXl5chqk7y7AWSUzJrAxQSoonHWkLXIuD54zXuRf939KcE1/I2gu8fMnG+Xwa+GQR1n4qEz8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771506974; c=relaxed/simple;
	bh=DbA0pVvkD81yH1UFr/+teBp0AtmqQoNA59E1qisFcRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEvfc/cL3dDvrouJl9ke2ZcvS8LL/h22XUUyaotbLNbzLaGmePt2maz9ADdWvkJBQ4BKavRiQlGOyzvtsjJzO5NCVChcSdDgpeOAetMPffZsh7VnYkMRlxncqiLFcy8C9PFmJfFC+WjUGxVwrIoqlRm406c6Ol2mVTTK8tis5qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=QMseGHyh; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-113-47.bstnma.fios.verizon.net [173.48.113.47])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 61JDEfrH015259
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 08:14:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1771506893; bh=YvzVGXRA9tq4Mexi8H81CMjCPQQmDTjjwr0q5r4ZxjY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=QMseGHyhfBaFWPX10hbUsMCruhrhgp9Y/y2cMCXsfRSODON0B5P+fIp1gbQDE498j
	 3kKA0mEvpnBkxC4fOP6ZE400XvESf8AzQ8W4hQYtEoVmenggeiuCZAsgDBp1wUb2cT
	 X6xiagrW3q1RCtta1iKSfDQKms5OjV5lnfxVAv8Q2AfkIOYoMk37GhEy8mDWLba8oU
	 +wzfcZxoHjbivvm4nlALGSOE0Sgx0+Y+qu96lZShmvpLYtEHFmEOzfCJdgvL6N1a6T
	 adL+YMa067AgExO/2xBFBiPTBuMQzJwlEaf6kQsPMFWsEHJLIbYxEGHfhvJQevk+z6
	 +8ydG6It0w42g==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 51D465919577; Thu, 19 Feb 2026 08:14:41 -0500 (EST)
Date: Thu, 19 Feb 2026 08:14:41 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Chuck Lever <cel@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org,
        sj1557.seo@samsung.com, yuezhang.mo@sony.com,
        almaz.alexandrovich@paragon-software.com, slava@dubeyko.com,
        glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
        adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org,
        pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com,
        trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org,
        chao@kernel.org, hansg@kernel.org, senozhatsky@chromium.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v8 08/17] ext4: Report case sensitivity in fileattr_get
Message-ID: <20260219131441.GA69183@macsyma-wired.lan>
References: <20260217214741.1928576-1-cel@kernel.org>
 <20260217214741.1928576-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217214741.1928576-9-cel@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5864-lists,linux-api=lfdr.de];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mit.edu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-api];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,macsyma-wired.lan:mid,suse.cz:email]
X-Rspamd-Queue-Id: CDEDD15EF63
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 04:47:32PM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Report ext4's case sensitivity behavior via the FS_XFLAG_CASEFOLD
> flag. ext4 always preserves case at rest.
> 
> Case sensitivity is a per-directory setting in ext4. If the queried
> inode is a casefolded directory, report case-insensitive; otherwise
> report case-sensitive (standard POSIX behavior).
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Acked-by: Theodore Ts'o <tytso@mit.edu>

