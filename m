Return-Path: <linux-api+bounces-5933-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHiQDjQMsmmmIAAAu9opvQ
	(envelope-from <linux-api+bounces-5933-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 12 Mar 2026 01:43:32 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B92426BBD5
	for <lists+linux-api@lfdr.de>; Thu, 12 Mar 2026 01:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E29803064F23
	for <lists+linux-api@lfdr.de>; Thu, 12 Mar 2026 00:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D205B347524;
	Thu, 12 Mar 2026 00:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qja1kEpd"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5E340855;
	Thu, 12 Mar 2026 00:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773276205; cv=none; b=rCsXGNSjNYH99fyum3L+sjfreHOmtPOPgdbU2mA9L/fz8gyuXmBfubWLvt+NOCmI9QYjO//12WYCkSMZ4CEJTugCSdtVGV4jF3kCZyW5OfpQOyYWY0g3NDyGsnw04Mb2bkQLmrI+KrjrUI3LRRbjmlH8FF1olP7e6rWbadJibi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773276205; c=relaxed/simple;
	bh=f1Ukgr3efBQJiUsGxkuNFR0VLqp/0IWF70o3BqoBpzg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGE+RnuRsK6uYaMO0x06DAtI0wvj2DkhS65JndiCpIlsnF8KbZZXrYDQ+x/9XQwIIgI/LUb3oouOnysbx9eGEiDZAXb/hi8Qr+NCK4iy4FyB8MsUTsxkn2G/LhtIibWx2afwlOSzj73RT5dq0VfX5VpOsS18X29/9b268rZnuRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qja1kEpd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E04FC4CEF7;
	Thu, 12 Mar 2026 00:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773276205;
	bh=f1Ukgr3efBQJiUsGxkuNFR0VLqp/0IWF70o3BqoBpzg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qja1kEpdEPXExPCUY+z/Xqq4Pq6ZLLHHmFP4PnHFNMINvB+n6L0ZROzxy64BMOEIP
	 DV9DznVIc1TTrkjwZ6Aq42GP9kYVipGZ6RDkUtjom+0JUNNJ4GQpvPZDzNdH6va3+y
	 bKzgdptw/ujQaqcY9w7jmyqtMCwIQxH8ZQCUUEajILinGl2HE8L8YmM90RnU5l0lqF
	 gyyRX/wwTwBUJtB6a4LIi3VJ71Hg+35sc4tKVllt9ibb8vNnOeV7FLv+vmwTwzkuPX
	 MCoIl06atfUq8ERCV1MY2WWgOmqQBtP1ZBkWHfnevgSTGeATvv2KSayJCuE3SACeaH
	 IcnIgI3xNlnBg==
Date: Wed, 11 Mar 2026 17:43:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wesley Atwell <atwellwea@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 ncardwell@google.com, dsahern@kernel.org, matttbe@kernel.org,
 martineau@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 kuniyu@google.com, horms@kernel.org, geliang@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, 0x7f454c46@gmail.com,
 linux-doc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org
Subject: Re: [PATCH net 0/7] tcp: preserve advertised rwnd accounting across
 receive-memory decisions
Message-ID: <20260311174323.10ce978b@kernel.org>
In-Reply-To: <20260311075600.948413-1-atwellwea@gmail.com>
References: <20260311075600.948413-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5933-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,google.com,kernel.org,vger.kernel.org,lists.linux.dev,lwn.net,linuxfoundation.org,goodmis.org,efficios.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B92426BBD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 01:55:53 -0600 Wesley Atwell wrote:
> Subject: [PATCH net 0/7] tcp: preserve advertised rwnd accounting across receive-memory decisions

when you repost please make sure you use "PATCH net-next v2" 
as the tag / prefix. "net" is a tree we use to fast track fixes.

