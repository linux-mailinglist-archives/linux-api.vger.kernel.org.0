Return-Path: <linux-api+bounces-5932-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UA3cEdgLsmmmIAAAu9opvQ
	(envelope-from <linux-api+bounces-5932-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 12 Mar 2026 01:42:00 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D99BC26BB97
	for <lists+linux-api@lfdr.de>; Thu, 12 Mar 2026 01:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 324EA3025101
	for <lists+linux-api@lfdr.de>; Thu, 12 Mar 2026 00:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF31C346E67;
	Thu, 12 Mar 2026 00:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw+LA19b"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B991A184;
	Thu, 12 Mar 2026 00:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773276117; cv=none; b=kNOZnYz3vco2+0YkU3hW32LJ4OpUkF6gOJNi5cOS1Mhw1ey67W380+u/bxAfnMwi6fuuM4sbtxtPfFzNVT0ESRwcFLn7Qc8Kzpxb9kDBlpNoRtyYzpnizIyNi39hhDujwORPblrHTefUavDw6D1+mBbxO7eZwT1iKFG3e6eh/FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773276117; c=relaxed/simple;
	bh=m0D3pcE3jYTk271mEEpVdN7yiHD5YT9bVKW+WrAU2QI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nrrz1RAKrGtU3e1ZRZa4RrDq1x1tyBGdgpeYKu+e+YhVu3qC4BIwxc+AfFiJjldF2B4tlaZuG9QsuHQRVykPd8nunn9tAAtMUhOMN7uvFGpyrycKsY0vITpsdIj19370ivZLL2Mle0sQknMWq3U7RRAjW4V/TGDOeId4TUzcXac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw+LA19b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EC2C4CEF7;
	Thu, 12 Mar 2026 00:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773276117;
	bh=m0D3pcE3jYTk271mEEpVdN7yiHD5YT9bVKW+WrAU2QI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bw+LA19bmpT0cC42EkfWWon734d//jcwuISX9USljTKKXf6iDURtEgTy3v6NC6Dr8
	 vEWx8oHqILiodJtOUBuqKBDW5pMh047H9qHoWXPfW4QcANCjkZ4q8pmsHOhZEwp6mz
	 B/m1znH22QYv9Hh9fOtXJYGSnSb5oTNXGJjSom8BHPXfGd16qbqmI9EWdcfDZt15H7
	 nLfJxEGogJVU8yCSIMj66qaVBP+vgxMgM4YnRH4NRZSHO13asmwL8NyyHfrnbRlClt
	 88itsj0Vr5oGUulRPyHzgrbPUknHBg6ofNQ6B/QpoxCUEyffOEOUXEsH7KgYVFd64N
	 zvgMi3y9zkr0Q==
Date: Wed, 11 Mar 2026 17:41:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Wesley Atwell <atwellwea@gmail.com>, Simon Baatz <gmbnomis@gmail.com>,
 davem@davemloft.net, pabeni@redhat.com, ncardwell@google.com,
 dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, kuniyu@google.com,
 horms@kernel.org, geliang@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, 0x7f454c46@gmail.com,
 linux-doc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org
Subject: Re: [PATCH net 0/7] tcp: preserve advertised rwnd accounting across
 receive-memory decisions
Message-ID: <20260311174154.5fadb207@kernel.org>
In-Reply-To: <CANn89i+dojcg=TDh6E1++g_TM7qdcpnyu47n2Q9DRW_w73TjzA@mail.gmail.com>
References: <20260311075600.948413-1-atwellwea@gmail.com>
	<CANn89i+dojcg=TDh6E1++g_TM7qdcpnyu47n2Q9DRW_w73TjzA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,redhat.com,google.com,kernel.org,vger.kernel.org,lists.linux.dev,lwn.net,linuxfoundation.org,goodmis.org,efficios.com];
	TAGGED_FROM(0.00)[bounces-5932-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D99BC26BB97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 09:34:32 +0100 Eric Dumazet wrote:
> Your series will heavily conflict with Simon's one
> 
> https://patchwork.kernel.org/project/netdevbpf/list/?series=1063486&state=%2A&archive=both
> 
> I suggest you rebase/retest/resend after we merge it.

Would it make sense to extend netdevsim and packetdrill to be able to
exercise scaling ratio a little more? Having it optionally clone the
skb and truesize += X would be trivial. IDK how many bugs this would
let us catch tho :(

