Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435482B27A8
	for <lists+linux-api@lfdr.de>; Fri, 13 Nov 2020 23:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgKMWDU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 13 Nov 2020 17:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgKMWCx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 13 Nov 2020 17:02:53 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3233AC0613D1;
        Fri, 13 Nov 2020 14:02:53 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CA1021E5E;
        Fri, 13 Nov 2020 22:02:52 +0000 (UTC)
Date:   Fri, 13 Nov 2020 15:02:51 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linux API <linux-api@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SELinux <selinux@vger.kernel.org>
Subject: Re: [RFC PATCH] docs: ABI: ABI documentation for procfs attribute
 files used by multiple LSMs
Message-ID: <20201113150251.16bfcbfe@lwn.net>
In-Reply-To: <30c36660-3694-0c0d-d472-8f3b3ca4098e@schaufler-ca.com>
References: <30c36660-3694-0c0d-d472-8f3b3ca4098e.ref@schaufler-ca.com>
        <30c36660-3694-0c0d-d472-8f3b3ca4098e@schaufler-ca.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 10 Nov 2020 09:28:41 -0800
Casey Schaufler <casey@schaufler-ca.com> wrote:

> Provide basic ABI descriptions for the process attribute entries
> that are shared between multiple Linux security modules.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  Documentation/ABI/testing/procfs-attr-current | 20 ++++++++++++++++++++
>  Documentation/ABI/testing/procfs-attr-exec    | 20 ++++++++++++++++++++
>  Documentation/ABI/testing/procfs-attr-prev    | 19 +++++++++++++++++++
>  3 files changed, 59 insertions(+)

I've applied this, thanks.

jon
