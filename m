Return-Path: <linux-api+bounces-2317-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C6897815A
	for <lists+linux-api@lfdr.de>; Fri, 13 Sep 2024 15:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1BC1F22B48
	for <lists+linux-api@lfdr.de>; Fri, 13 Sep 2024 13:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BA51D9358;
	Fri, 13 Sep 2024 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="rHKCAJL8"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD1E1D6C7A
	for <linux-api@vger.kernel.org>; Fri, 13 Sep 2024 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726234815; cv=none; b=mCn2Y4t/HqNaPl7RiRS4PxuxGlDPyv8ZcB/ohCv7fDb/dPx5rVoLsx1K1scJVy87d0NNqQF8JaHp6KV9p175gMAqrMVf7WGuyUcLvuJbUMvV+ZGCG2sey9dgBC+weCcY3X+CDqE8/9lkxFIp/V37VARpbl5c3cOVGKe4uAOnLt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726234815; c=relaxed/simple;
	bh=FuLavyQvHtM8WNrI6vKqzszV+dUVTGkQOGNr5SLyZC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bABWM4okMRR10km+cfCNhR2Mv7b/YWWkVAE/+uzAB0KPOfYBy3s8KitFfmn7/0gWRMwjrZnlOae5PlfcHaTn8FDwQwWayTJEA0T7EzdeiGB2RD0Ta3TXMbT8NckAQl9UyP3MEdUWsken/Sge7h/ZZ5pG56K1IGklOj7E4r4ogPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=rHKCAJL8; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4X4wH83tfjzgWW;
	Fri, 13 Sep 2024 15:33:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1726234388;
	bh=MH8HjPJeBlhN/lWhWBgQcXkOURL5N2O7tfwxaECdnFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rHKCAJL8t1bdaLNqjn89ZGONAIOviOasFHZS3MK8w73wdLPvihXWzz/n4NNcCC0ZD
	 bOe9KY1bV3n04AQIH9Y/TK+opSL9NA/PLQdazDyfx9phHwm962fsuFzk97IPAIJ81o
	 fCS3LXWubgoWrnYigeSczWA7VS6P8xC3tNYVGw0U=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4X4wH64ldfzZ9Z;
	Fri, 13 Sep 2024 15:33:06 +0200 (CEST)
Date: Fri, 13 Sep 2024 15:32:59 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>, linux-api@vger.kernel.org
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v11 1/8] Landlock: Add abstract UNIX socket restriction
Message-ID: <20240913.AmeeLo0aeheD@digikod.net>
References: <cover.1725494372.git.fahimitahera@gmail.com>
 <5f7ad85243b78427242275b93481cfc7c127764b.1725494372.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f7ad85243b78427242275b93481cfc7c127764b.1725494372.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Sep 04, 2024 at 06:13:55PM -0600, Tahera Fahimi wrote:
> This patch introduces a new "scoped" attribute to the
> landlock_ruleset_attr that can specify
> "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" to scope abstract UNIX sockets
> from connecting to a process outside of the same Landlock domain. It
> implements two hooks, unix_stream_connect and unix_may_send to enforce
> this restriction.
> 
> Closes: https://github.com/landlock-lsm/linux/issues/7
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> 
> ---
> v11:
> - For a connected abstract datagram socket, the hook_unix_may_send
>   allows the socket to send a data. (it is treated as a connected stream
>   socket)
> - Minor comment revision.
> v10:
> - Minor code improvement based on reviews on v9.
> v9:
> - Editting inline comments.
> - Major refactoring in domain_is_scoped() and is_abstract_socket
> v8:
> - Code refactoring (improve code readability, renaming variable, etc.)
>   based on reviews by Mickaël Salaün on version 7.
> - Adding warn_on_once to check (impossible) inconsistencies.
> - Adding inline comments.
> - Adding check_unix_address_format to check if the scoping socket is an
>   abstract UNIX sockets.
> v7:
> - Using socket's file credentials for both connected(STREAM) and
>   non-connected(DGRAM) sockets.
> - Adding "domain_sock_scope" instead of the domain scoping mechanism
>   used in ptrace ensures that if a server's domain is accessible from
>   the client's domain (where the client is more privileged than the
>   server), the client can connect to the server in all edge cases.
> - Removing debug codes.
> v6:
> - Removing curr_ruleset from landlock_hierarchy, and switching back to
>   use the same domain scoping as ptrace.
> - code clean up.
> v5:
> - Renaming "LANDLOCK_*_ACCESS_SCOPE" to "LANDLOCK_*_SCOPE"
> - Adding curr_ruleset to hierarachy_ruleset structure to have access
>   from landlock_hierarchy to its respective landlock_ruleset.
> - Using curr_ruleset to check if a domain is scoped while walking in the
>   hierarchy of domains.
> - Modifying inline comments.
> v4:
> - Rebased on Günther's Patch:
>   https://lore.kernel.org/all/20240610082115.1693267-1-gnoack@google.com/
>   so there is no need for "LANDLOCK_SHIFT_ACCESS_SCOPE", then it is
>   removed.
> - Adding get_scope_accesses function to check all scoped access masks in
>   a ruleset.
> - Using socket's file credentials instead of credentials stored in
>   peer_cred for datagram sockets. (see discussion in [1])
> - Modifying inline comments.
> V3:
> - Improving commit description.
> - Introducing "scoped" attribute to landlock_ruleset_attr for IPC
>   scoping purpose, and adding related functions.
> - Changing structure of ruleset based on "scoped".
> - Removing rcu lock and using unix_sk lock instead.
> - Introducing scoping for datagram sockets in unix_may_send.
> V2:
> - Removing wrapper functions
> 
> [1]https://lore.kernel.org/all/20240610.Aifee5ingugh@digikod.net/
> ---
>  include/uapi/linux/landlock.h                |  28 ++++
>  security/landlock/limits.h                   |   3 +
>  security/landlock/ruleset.c                  |   7 +-
>  security/landlock/ruleset.h                  |  24 +++-
>  security/landlock/syscalls.c                 |  17 ++-
>  security/landlock/task.c                     | 136 +++++++++++++++++++
>  tools/testing/selftests/landlock/base_test.c |   2 +-
>  7 files changed, 208 insertions(+), 9 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 2c8dbc74b955..dfd48d722834 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -44,6 +44,12 @@ struct landlock_ruleset_attr {
>  	 * flags`_).
>  	 */
>  	__u64 handled_access_net;
> +	/**
> +	 * @scoped: Bitmask of scopes (cf. `Scope flags`_)
> +	 * restricting a Landlock domain from accessing outside
> +	 * resources(e.g. IPCs).
> +	 */
> +	__u64 scoped;
>  };
>  
>  /*
> @@ -274,4 +280,26 @@ struct landlock_net_port_attr {
>  #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
>  #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
>  /* clang-format on */
> +
> +/**
> + * DOC: scope
> + *
> + * Scope flags
> + * ~~~~~~~~~~~
> + *
> + * These flags enable to restrict a sandboxed process from a set of IPC
> + * actions. Setting a flag for a ruleset will isolate the Landlock domain
> + * to forbid connections to resources outside the domain.
> + *
> + * IPCs with scoped actions:
> + *
> + * - %LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET: Restrict a sandboxed process
> + *   from connecting to an abstract unix socket created by a process
> + *   outside the related Landlock domain (e.g. a parent domain or a
> + *   non-sandboxed process).
> + */
> +/* clang-format off */
> +#define LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET		(1ULL << 0)

Thinking more about it, it makes more sense to rename it to
LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET (s/SCOPED/SCOPE/) because it
express a scope (not a "scoped") and it allign with the current
LANDLOCK_ACCESS_* and other internal variables such as
LANDLOCK_LAST_SCOPE...

However, it still makes sense to keep the "scoped" ruleset's field,
which is pretty similar to the "handled_*" semantic: it describes what
will be *scoped* by the ruleset.

> +/* clang-format on*/
> +
>  #endif /* _UAPI_LINUX_LANDLOCK_H */
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index 4eb643077a2a..eb01d0fb2165 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -26,6 +26,9 @@
>  #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
>  #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
>  
> +#define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET
> +#define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
> +#define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
>  /* clang-format on */

