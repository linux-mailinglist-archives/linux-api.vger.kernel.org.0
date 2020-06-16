Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC35D1FB521
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2020 16:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgFPO4D (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Jun 2020 10:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbgFPOz4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Jun 2020 10:55:56 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38847C061755
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 07:55:56 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id s23so9621009pfh.7
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WNF9etpx10znAFg91RybrVxjbrhe0SORwIJGFu/T2UE=;
        b=Eqdpy+33nHh0lF7JF1m9J/2+1L9E7YnO+9jfEZuq3UI/RtVUUHQVHJvCDanJerqWA7
         ke86DqQxPt4PJ+Cysy87uPh4Jw1Qle29wA7xfamR9Nvmp8kdyNbUaTwzmj/Sa0XmmA90
         0WE9k76KpN7BXtUy8CBHlD/SWxWCcNncR/Hm973B556cZbOr1N2whMKPI1Ta/nFo7g3W
         IjR/P04OOdBe2q66j1pqP6EBkvzUEqzxeVkuYlcJJ4hxE4qwQK+CzHxKvm0yrl2Stif0
         K8HE3EFLjLBFu65x242zaO4xDYTtJbWQaoee+qw3HvhKpFXbbds3TF5/FyO+id1AwRRE
         1g8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WNF9etpx10znAFg91RybrVxjbrhe0SORwIJGFu/T2UE=;
        b=jMb5VnxGTCq5zlASD0JnGk5UaSB+i/ZvDVwp6nysofr+fByh6mKRiqB98qhwLUpd8W
         mFzh+tXSOyJ21Ecpu/XCNtM5/VORu0BT+JeiJazGjPyk3RBmr8NjOkLBl+aZgOnhPUz2
         OEXK9Yw2Mqgsr1uBZ31Dg8pvNDxq3acRyMpm8GpFH4fvLF02GejJ5wqvRwZ0tk2AsjmH
         4VNanhuus3CJNSnXVb0BSilUB3gLDBMZZGuMCKkbP/jcB89k239S8oSaMk9eOr3zoE8u
         4u0sWCpzDqG5SZYkAQCSjwdciLz27UwvQ3+zaLdqfezjvG6sOSjqufGSyt2eotgqVSqn
         YdUQ==
X-Gm-Message-State: AOAM532ohkep0tMb9ymzzoVXbwbqp0ruJdppfFXLiTal1RxfFiJ+FVhn
        SeN+EFLnIrSe7kPEj/iIQ262dg==
X-Google-Smtp-Source: ABdhPJy4AncAs73T1e7CsZ7TL7HXTr6/HNDo5w5qHUb1x+Sc9NKoQNKVk+mYwyd/Dqt2WPYE59Sd3g==
X-Received: by 2002:aa7:859a:: with SMTP id w26mr2342599pfn.10.1592319354221;
        Tue, 16 Jun 2020 07:55:54 -0700 (PDT)
Received: from cisco ([2001:420:c0c8:1007::16e])
        by smtp.gmail.com with ESMTPSA id s98sm2942415pjb.33.2020.06.16.07.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 07:55:53 -0700 (PDT)
Date:   Tue, 16 Jun 2020 08:55:46 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 10/11] seccomp: Switch addfd to Extensible Argument
 ioctl
Message-ID: <20200616145546.GH2893648@cisco>
References: <20200616032524.460144-1-keescook@chromium.org>
 <20200616032524.460144-11-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616032524.460144-11-keescook@chromium.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 15, 2020 at 08:25:23PM -0700, Kees Cook wrote:
> This patch is based on discussions[1] with Sargun Dhillon, Christian
> Brauner, and David Laight. Instead of building size into the addfd
> structure, make it a function of the ioctl command (which is how sizes are
> normally passed to ioctls). To support forward and backward compatibility,
> just mask out the direction and size, and match everything. The size (and
> any future direction) checks are done along with copy_struct_from_user()
> logic. Also update the selftests to check size bounds.
> 
> [1] https://lore.kernel.org/lkml/20200612104629.GA15814@ircssh-2.c.rugged-nimbus-611.internal
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/uapi/linux/seccomp.h                  |  2 -
>  kernel/seccomp.c                              | 21 ++++++----
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 40 ++++++++++++++++---
>  3 files changed, 49 insertions(+), 14 deletions(-)
> 
> diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> index c347160378e5..473a61695ac3 100644
> --- a/include/uapi/linux/seccomp.h
> +++ b/include/uapi/linux/seccomp.h
> @@ -118,7 +118,6 @@ struct seccomp_notif_resp {
>  
>  /**
>   * struct seccomp_notif_addfd
> - * @size: The size of the seccomp_notif_addfd structure
>   * @id: The ID of the seccomp notification
>   * @flags: SECCOMP_ADDFD_FLAG_*
>   * @srcfd: The local fd number
> @@ -126,7 +125,6 @@ struct seccomp_notif_resp {
>   * @newfd_flags: The O_* flags the remote FD should have applied
>   */
>  struct seccomp_notif_addfd {
> -	__u64 size;

Huh? Won't this break builds?

Tycho
