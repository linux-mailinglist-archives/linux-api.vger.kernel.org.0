Return-Path: <linux-api+bounces-230-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D493804C87
	for <lists+linux-api@lfdr.de>; Tue,  5 Dec 2023 09:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF64B1F214E3
	for <lists+linux-api@lfdr.de>; Tue,  5 Dec 2023 08:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DEF339A4;
	Tue,  5 Dec 2023 08:35:50 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3D69C;
	Tue,  5 Dec 2023 00:35:46 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B5CCD21E40;
	Tue,  5 Dec 2023 08:35:44 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A793E136CF;
	Tue,  5 Dec 2023 08:35:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8JPnKODgbmWjPAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 05 Dec 2023 08:35:44 +0000
Date: Tue, 5 Dec 2023 09:35:44 +0100
From: Michal Hocko <mhocko@suse.com>
To: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
Cc: aneesh.kumar@linux.ibm.com, linux-cxl@vger.kernel.org,
	linux-mm@kvack.org, dan.j.williams@intel.com, hannes@cmpxchg.org,
	hasanalmaruf@fb.com, haowang3@fb.com, ying.huang@intel.com,
	gregory.price@memverge.com, tj@kernel.org,
	hezhongkun.hzk@bytedance.com, fvdl@google.com, john@jagalactic.com,
	emirakhur@micron.com, vtavarespetr@micron.com,
	Ravis.OpenSrc@micron.com, Jonathan.Cameron@huawei.com,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [EXT] Re: [RFC PATCH 0/2] Node migration between memory tiers
Message-ID: <ZW7g4ExYF79gMEBU@tiehlicka>
References: <20231130220422.2033-1-sthanneeru.opensrc@micron.com>
 <ZW3zl2Fke5FtQCv3@tiehlicka>
 <1db561a9-6984-418d-9305-a2a5ece93696@micron.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1db561a9-6984-418d-9305-a2a5ece93696@micron.com>
X-Spamd-Bar: +++++++++++++++++++++
X-Spam-Score: 21.50
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	spf=fail (smtp-out1.suse.de: domain of mhocko@suse.com does not designate 2a07:de40:b281:104:10:150:64:97 as permitted sender) smtp.mailfrom=mhocko@suse.com;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine)
X-Rspamd-Queue-Id: B5CCD21E40
X-Spamd-Result: default: False [21.50 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_SPF_FAIL(1.00)[-all];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_SPAM_SHORT(3.00)[0.999];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 RCPT_COUNT_TWELVE(0.00)[20];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Tue 05-12-23 01:26:07, Srinivasulu Thanneeru wrote:
> 
> 
> On 12/4/2023 9:13 PM, Michal Hocko wrote:
> > CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless you recognize the sender and were expecting this message.
> > 
> > 
> > On Fri 01-12-23 03:34:20, sthanneeru.opensrc@micron.com wrote:
> > > From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
> > > 
> > > The memory tiers feature allows nodes with similar memory types
> > > or performance characteristics to be grouped together in a
> > > memory tier. However, there is currently no provision for
> > > moving a node from one tier to another on demand.
> > 
> > Could you expand on why this is really needed/necessary? What is the
> > actual usecase?
> 
> Hi Michal Hock,
> 
> Following two use-cases we have observed.
> 1. It is not accurate to group similar memory types in the same tier,
>    because even similar memory types may have different speed grades.

Presumably they are grouped based on a HW configuration. Does that mean
that the configuration is wrong? Are you trying to workaround that by
this interface?

> 2. Some systems boots up with CXL devices and DRAM on the same memory-tier,
> we need a way to move the CXL nodes to the correct tier from the user space.

Again, could you expand a bit more and explain why this cannot be
configured automatically?
-- 
Michal Hocko
SUSE Labs

