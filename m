Return-Path: <linux-api+bounces-222-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E8E803910
	for <lists+linux-api@lfdr.de>; Mon,  4 Dec 2023 16:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221652810FD
	for <lists+linux-api@lfdr.de>; Mon,  4 Dec 2023 15:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74B12C872;
	Mon,  4 Dec 2023 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tj/UJeCd"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A12ECA;
	Mon,  4 Dec 2023 07:43:22 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 89F8E1F8CC;
	Mon,  4 Dec 2023 15:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701704600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YOaNcpQ6My2bUhBcS70FOu0bLg5v5vZHCTRkgHEbbYM=;
	b=tj/UJeCdsMGyPWGdKIizicxYxzBgTyG1loqLjwj9GNYY5CVkpbGvV79Sugd3/xJZYqnx5P
	0cM9dGOVT7TG1MmP/dBn/0UEwDd59VfveUq3avVaAKDudbopYSwMw26Rfmg6R/plnXcaey
	8vK4WDl22XY+fI2mSXzqxXBlvrw21Ps=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64AAF139AA;
	Mon,  4 Dec 2023 15:43:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VZXlFZjzbWU9WgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 04 Dec 2023 15:43:20 +0000
Date: Mon, 4 Dec 2023 16:43:19 +0100
From: Michal Hocko <mhocko@suse.com>
To: sthanneeru.opensrc@micron.com
Cc: aneesh.kumar@linux.ibm.com, linux-cxl@vger.kernel.org,
	linux-mm@kvack.org, dan.j.williams@intel.com, hannes@cmpxchg.org,
	hasanalmaruf@fb.com, haowang3@fb.com, ying.huang@intel.com,
	gregory.price@memverge.com, tj@kernel.org,
	hezhongkun.hzk@bytedance.com, fvdl@google.com, john@jagalactic.com,
	emirakhur@micron.com, vtavarespetr@micron.com,
	Ravis.OpenSrc@micron.com, Jonathan.Cameron@huawei.com,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Node migration between memory tiers
Message-ID: <ZW3zl2Fke5FtQCv3@tiehlicka>
References: <20231130220422.2033-1-sthanneeru.opensrc@micron.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130220422.2033-1-sthanneeru.opensrc@micron.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.22
X-Spamd-Result: default: False [-3.22 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[20];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.62)[98.31%]

On Fri 01-12-23 03:34:20, sthanneeru.opensrc@micron.com wrote:
> From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
> 
> The memory tiers feature allows nodes with similar memory types
> or performance characteristics to be grouped together in a
> memory tier. However, there is currently no provision for
> moving a node from one tier to another on demand.

Could you expand on why this is really needed/necessary? What is the
actual usecase?
-- 
Michal Hocko
SUSE Labs

