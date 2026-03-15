Return-Path: <linux-api+bounces-5984-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NduFigJtmlq8gAAu9opvQ
	(envelope-from <linux-api+bounces-5984-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 15 Mar 2026 02:19:36 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3A128FBC6
	for <lists+linux-api@lfdr.de>; Sun, 15 Mar 2026 02:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F0C1306B17D
	for <lists+linux-api@lfdr.de>; Sun, 15 Mar 2026 01:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE821A3164;
	Sun, 15 Mar 2026 01:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN8a5zxe"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DDF78F2F;
	Sun, 15 Mar 2026 01:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773537522; cv=none; b=Lgi8oCYxriMDl8GpH480icHAbN7gIonCpCxPWS03+q7hVAipkD4DGRGuACqDN8jFvGE08K0pgSKbeA/+aHrHuKW/b3JLYqygEm1cV2hxHYg6TF/exOE/5ncUBigV/coXVx5l2PkTtcmPPFEPt4FQI7akxgCWSTDHxHAEw0ok+xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773537522; c=relaxed/simple;
	bh=S61dtpSSOz1j7UBL9WOGbhg8/KLi+VusQ9w+iWvVfq8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPRzVoHTkAT9YeIXBI1Ua/TfXKM4uGILWkqaYlgSRg7jiafGnW0YkrtRo6mCk29dw1pcZGOKma+6XS1tttLfZMkDT4UciTo3NbL+N5ogmuf1LGxUAgcn0LaLgRFBWSwvsoGfeq1mxNElpWtE6JGCJZMRbPUV20bi8EkVxxLa+qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hN8a5zxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DB2C116C6;
	Sun, 15 Mar 2026 01:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773537521;
	bh=S61dtpSSOz1j7UBL9WOGbhg8/KLi+VusQ9w+iWvVfq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hN8a5zxeiGnPtXvCrk+ZIRABC+lRAoqIxqtPkYxxyeUppQ6n+KQZSCzomj/7WQB66
	 tRmI+QvSY0GSiu+/nlUASGg0yftAg7TfOpNWhVqeR0svn/+5OviHxgELO6vSBhDsw1
	 6wVh8wkxuRhxCgU7AgnNAE8vb6i4tkzci8+kMohWTczMLZ7RJNCuGmobEBpLWV+aZg
	 j/g6SCzS55m5Uwf1EGXB1VU4iZk/U/k3XFzuNFyBGF7doJf4bMreeX6AJbxYdMpgPp
	 nvW2QpxLNrpwVz4B/cXmPLUfYiCLccyKPrhNaXiefo7I0cbL3zctS6I6SNVCe4XBX4
	 t9XZUmZ1jRIlw==
Date: Sat, 14 Mar 2026 18:18:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: atwellwea@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, ncardwell@google.com, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mptcp@lists.linux.dev, dsahern@kernel.org, horms@kernel.org,
 kuniyu@google.com, andrew+netdev@lunn.ch, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, skhan@linuxfoundation.org, corbet@lwn.net,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 0x7f454c46@gmail.com
Subject: Re: [PATCH net-next v2 12/14] tun/selftests: add RX truesize
 injection for TCP window tests
Message-ID: <20260314181839.1c3da7c3@kernel.org>
In-Reply-To: <20260314201348.1786972-13-atwellwea@gmail.com>
References: <20260314201348.1786972-1-atwellwea@gmail.com>
	<20260314201348.1786972-13-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,redhat.com,google.com,lists.linux.dev,kernel.org,lunn.ch,gmail.com,linuxfoundation.org,lwn.net,goodmis.org,efficios.com];
	TAGGED_FROM(0.00)[bounces-5984-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC3A128FBC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 14 Mar 2026 14:13:46 -0600 atwellwea@gmail.com wrote:
> Add a test-only TUN ioctl that inflates RX skb->truesize, plus the
> packetdrill-side helper needed to drive that ioctl through packetdrill's
> own TUN queue file descriptor.
> 
> Use that plumbing to cover the receive-window regressions where
> scaling_ratio drifts after advertisement, alongside the baseline too-big
> packetdrill cases that exercise the same sender-visible rwnd accounting
> from the non-injected path.

You missed adding the tun program to the Makefile.

  tcp-rcv-neg-window-truesize-pkt                                               
  tcp-rcv-toobig-default-truesize-pkt                                           
  tcp-rcv-wnd-shrink-allowed-truesize-pkt                                       
                                                                               
Fail with:                                                            

  sh: line 1: ../tun: No such file or directory                                 
  tcp_rcv_*_truesize.pkt:*: error executing `../tun --set-rx-truesize tun0 6553\
6` command: non-zero status 127        

https://netdev.bots.linux.dev/contest.html?pw-n=0&branch=net-next-2026-03-15--00-00&pw-n=0&pass=0

