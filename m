Return-Path: <linux-api+bounces-5985-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHimIVkJtmlq8gAAu9opvQ
	(envelope-from <linux-api+bounces-5985-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 15 Mar 2026 02:20:25 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 272CB28FBF1
	for <lists+linux-api@lfdr.de>; Sun, 15 Mar 2026 02:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68E8C305CA91
	for <lists+linux-api@lfdr.de>; Sun, 15 Mar 2026 01:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA8A202F65;
	Sun, 15 Mar 2026 01:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfJmdOBo"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D1C1D435F;
	Sun, 15 Mar 2026 01:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773537597; cv=none; b=RMkwhjm0ubSuBYYJDDKeMza3I+Uxz1ad77rJqbM4V3y6nLQLVcV5KySJ99yP84jBntquRWGu4WGkn8CRkhpInOCanQGMRpq0x6mmfEybwNCVFTlNl6HkVI5JUIQ/zhNGr6bOTSj8zdpp24MFbFpPqK7gPqHUj5VLTgGK0VpZLzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773537597; c=relaxed/simple;
	bh=h0DG2xaeR8KdeW9n8FazcNV9h5yIblTYtboeu3f9tlM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQlugDw8sSK0mUD8emiEr7H7vUrCqjiqaRJCHQ+zFB9QVkL3eQ8XIYHFpQx31BbQGLG7CP8LZKIeT+EL33vfW5Yy6xd4+P+RvLwasg5QrXuwDpOvRSRiB4haBXzWTQLGaiCO1SnVWyLvj+Y+OP9DBUOM3WqdN62BVk+Pxn02H1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfJmdOBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA66C116C6;
	Sun, 15 Mar 2026 01:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773537596;
	bh=h0DG2xaeR8KdeW9n8FazcNV9h5yIblTYtboeu3f9tlM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZfJmdOBoJAmvtPI7jXoLWF8KeSOFXjuAnu64PxZdyM2ezxmUQq+hen21t42T72mcy
	 ovIkIrHtiE7TkJ7TBdMIFIlLjhrOkk86aKhn+P+5ZdukxSgx1W0OmbWr+SITCf0t+k
	 Gmbyav+GO4ERrXUXeNsvKOLz3sSawKdRIspI9djl5VJ3Mj8CH9dJrWYW+SeldsDskf
	 eXrIXnHzd4PuM8swOogh5J9u3ZuuYkSDwfDp93R8xKSA8iJoDcYiW5LB9CyeHdDlYx
	 Wa1+NsuGbtF5DjyU9GaEU5ofdQAfkOOQw0V4s5DvD/N3dvg/too+j8WHNls0lP7Mg/
	 e3J6fhaNfdwDw==
Date: Sat, 14 Mar 2026 18:19:54 -0700
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
Subject: Re: [PATCH net-next v2 00/14] tcp: preserve receive-window
 accounting across ratio drift
Message-ID: <20260314181954.390bf6bc@kernel.org>
In-Reply-To: <20260314201348.1786972-1-atwellwea@gmail.com>
References: <20260314201348.1786972-1-atwellwea@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-5985-lists,linux-api=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 272CB28FBF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 14 Mar 2026 14:13:34 -0600 atwellwea@gmail.com wrote:
> This series keeps sender-visible TCP receive-window accounting tied to the
> scaling basis that was in force when the window was advertised, even if
> later receive-side truesize inflation lowers scaling_ratio or the live
> receive window retracts below the largest right edge already exposed to the
> sender.

Please wait until at least Monday before reposting this.
LLM-pocalypse is hitting us hard

