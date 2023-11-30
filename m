Return-Path: <linux-api+bounces-188-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C427FF88E
	for <lists+linux-api@lfdr.de>; Thu, 30 Nov 2023 18:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37301C20BDD
	for <lists+linux-api@lfdr.de>; Thu, 30 Nov 2023 17:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A74A5812A;
	Thu, 30 Nov 2023 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBRkWuQd"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E914D197
	for <linux-api@vger.kernel.org>; Thu, 30 Nov 2023 09:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701366055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Foztye0H5OMwSOdTOC/HcbTeXr+DTPVH4rsYB2c+xo=;
	b=VBRkWuQdXbCWMbzqhoGJvJmRjbW7YqkT8B8pJ9JHtxE2kW7TtAPGApllm5Hk8oeEPBLv2F
	UL1Pw+MUTyBsu99Xm4hsrOkiAw6/B72ezJ2NAxPCNx8rA/LlwCNLP4zNaGYi56yWLX8KHx
	OjPY29MWmsVPezFYHCs13dxmaoVsuTA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-INjEAH18OGWI7NXMeaPLkw-1; Thu,
 30 Nov 2023 12:40:48 -0500
X-MC-Unique: INjEAH18OGWI7NXMeaPLkw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99FC73814E99;
	Thu, 30 Nov 2023 17:40:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.2])
	by smtp.corp.redhat.com (Postfix) with SMTP id 0373840C6EBA;
	Thu, 30 Nov 2023 17:40:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 30 Nov 2023 18:39:41 +0100 (CET)
Date: Thu, 30 Nov 2023 18:39:39 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Christian Brauner <brauner@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
Message-ID: <20231130173938.GA21808@redhat.com>
References: <20231130163946.277502-1-tycho@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130163946.277502-1-tycho@tycho.pizza>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Hi Tycho,

I can't really read this patch now, possibly I am wrong, but...

On 11/30, Tycho Andersen wrote:
>
> @@ -263,16 +263,25 @@ void release_task(struct task_struct *p)
>  	 */
>  	zap_leader = 0;
>  	leader = p->group_leader;
> -	if (leader != p && thread_group_empty(leader)
> -			&& leader->exit_state == EXIT_ZOMBIE) {
> -		/*
> -		 * If we were the last child thread and the leader has
> -		 * exited already, and the leader's parent ignores SIGCHLD,
> -		 * then we are the one who should release the leader.
> -		 */
> -		zap_leader = do_notify_parent(leader, leader->exit_signal);
> -		if (zap_leader)
> -			leader->exit_state = EXIT_DEAD;
> +	if (leader != p) {
> +		if (thread_group_empty(leader)
> +				&& leader->exit_state == EXIT_ZOMBIE) {
> +			/*
> +			 * If we were the last child thread and the leader has
> +			 * exited already, and the leader's parent ignores SIGCHLD,
> +			 * then we are the one who should release the leader.
> +			 */
> +			zap_leader = do_notify_parent(leader,
> +						      leader->exit_signal);
> +			if (zap_leader)
> +				leader->exit_state = EXIT_DEAD;
> +		} else {
> +			/*
> +			 * wake up pidfd pollers anyway, they want to know this
> +			 * thread is dying.
> +			 */
> +			wake_up_all(&thread_pid->wait_pidfd);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

somehow I can't believe this is a good change after a quick glance ;)

I think that wake_up_all(wait_pidfd) should have a single caller,
do_notify_pidfd(). This probably means it should be shiftef from
do_notify_parent() to exit_notify(), I am not sure...

No?

Oleg.


