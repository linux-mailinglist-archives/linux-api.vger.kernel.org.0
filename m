Return-Path: <linux-api+bounces-5942-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KK/cD0cmtGmgiAAAu9opvQ
	(envelope-from <linux-api+bounces-5942-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 15:59:19 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D252856DE
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 15:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02919325C4DE
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 14:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647643A8733;
	Fri, 13 Mar 2026 14:54:41 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from cventin.lip.ens-lyon.fr (cventin.lip.ens-lyon.fr [140.77.13.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A9537FF41;
	Fri, 13 Mar 2026 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.13.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773413681; cv=none; b=mnGrHvY3rQR/41tfk5g1w0Qf3t2c+AdPNZNkLSTSokbUIqcAS56FiSorC6XjB52ySCtF63WLBRnoZBKpFMRnxVzLzLUiPnVqScsY3DtDCA8kQJI0J4rn7+lJpH48/tIv4kHdey7WJ/MXqBmgnSSNJfAAapcBbHj7DZ0BNOVwkVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773413681; c=relaxed/simple;
	bh=H7vCL0+zysP04HJzcF2uKzM/fNmzUKnv5Pjj3BJ4cwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMm9Ysm1E8cG2TrGvhwe9TNZZODodYVNEpq5goJ9nMy0yRCGhU1I6B8PTO5TR9OPR2azx4P4H+rIQhHeKLghSeNsUnI8Yp4RULti5K5IizSqsAp5e1jptITfzmso7Huc/egnDVJ1/+Q87qpwXauMGB6FHzFdgc3AHc800x+NgJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vinc17.net; spf=pass smtp.mailfrom=vinc17.net; arc=none smtp.client-ip=140.77.13.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vinc17.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinc17.net
Received: from vlefevre by cventin.lip.ens-lyon.fr with local (Exim 4.99.1)
	(envelope-from <vincent@vinc17.net>)
	id 1w13lE-000000001aB-0DJ9;
	Fri, 13 Mar 2026 15:45:08 +0100
Date: Fri, 13 Mar 2026 15:45:08 +0100
From: Vincent Lefevre <vincent@vinc17.net>
To: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Cc: Roman Bakshansky <bakshansky.lists@gmail.com>,
	linux-api@vger.kernel.org, Thorsten Kukuk <kukuk@suse.com>,
	linux-kernel@vger.kernel.org, audit@vger.kernel.org,
	libc-alpha@sourceware.org
Subject: Re: [RFC] Modernizing Linux authentication logs (lastlog, btmp,
 utmp, wtmp) with SQLite
Message-ID: <20260313144508.GA5446@cventin.lip.ens-lyon.fr>
Mail-Followup-To: Vincent Lefevre <vincent@vinc17.net>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Roman Bakshansky <bakshansky.lists@gmail.com>,
	linux-api@vger.kernel.org, Thorsten Kukuk <kukuk@suse.com>,
	linux-kernel@vger.kernel.org, audit@vger.kernel.org,
	libc-alpha@sourceware.org
References: <660c10e6-f8b5-46e2-a424-e3e052992b3a@gmail.com>
 <2d5de14a-17d2-4d08-992e-cbc5d430e231@linaro.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d5de14a-17d2-4d08-992e-cbc5d430e231@linaro.org>
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.3+4 (71f3e314) vl-169878 (2026-01-27)
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5942-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,suse.com,sourceware.org];
	DMARC_NA(0.00)[vinc17.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent@vinc17.net,linux-api@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.993];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sourceware.org:url,vinc17.net:email,vinc17.net:url]
X-Rspamd-Queue-Id: 49D252856DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-13 10:59:11 -0300, Adhemerval Zanella Netto wrote:
> From the glibc standpoint my plan is just to make the accounting database
> function no-op [1] (I hopefully to get this in the next 2.44 release).
> 
> And I think Thorsten Kukuk already adapted most of the usages in current
> distros [2][3] using similar strategy, along with a better systemd
> integration.  I am not sure if/when distros are incorporating his work.
> 
> [1] https://patchwork.sourceware.org/project/glibc/list/?series=37271
> [2] https://www.thkukuk.de/blog/Y2038_glibc_lastlog_64bit/
> [3] https://www.thkukuk.de/blog/Y2038_glibc_utmp_64bit/

FYI, utmp has been reintroduced in Debian for libutempter (and thus
applications that use this library), because systemd was not working
or at least not sufficiently documented:

  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1125682

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / Pascaline project (LIP, ENS-Lyon)

