Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99B225363E
	for <lists+linux-api@lfdr.de>; Wed, 26 Aug 2020 20:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgHZSC7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 26 Aug 2020 14:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgHZSC6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 26 Aug 2020 14:02:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB89C061574;
        Wed, 26 Aug 2020 11:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=mShoHnabcEwjLMnW9gTjGmQe26962ZfrGYbtNUBfp98=; b=KuwL89BQQ50l3S2q48Px0USuuT
        Gq8vGSmEx7aaHDZS86Ez8JbCnEKXCzoT8h0G6G59ZE2vcbBdjhUuIZ4MNWqn+AbTDpnzwqf1nXt4D
        Rxrx6L46lnw30SXQizvImv8X0I5P2xSLJwgiJftsUATxDNpFJ0a+kqL7qWjo5ihfug6kYPkFuWzVh
        gyEV/m7NdTq6UQGw8xrQHb+W52CnVM+YrmTijb1B0KSHjfTEKLkMnvqwBWKCF2owKcTnDURH0N0Qp
        fDZB4naQcgdhlnSqS8KdUC90IXQVQ6ssKv+uYd4J+yhBuzdG/xETDNjg1Vsi8rXoURCSekRy7pZcq
        5L/AFMLA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAzl5-0000E8-98; Wed, 26 Aug 2020 18:02:51 +0000
Subject: Re: [PATCH v20 22/23] LSM: Add /proc attr entry for full LSM context
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-api@vger.kernel.org
References: <20200826145247.10029-1-casey@schaufler-ca.com>
 <20200826145247.10029-23-casey@schaufler-ca.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2e16e5dc-d040-8e8d-0fda-eb631b4b72e1@infradead.org>
Date:   Wed, 26 Aug 2020 11:02:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826145247.10029-23-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

On 8/26/20 7:52 AM, Casey Schaufler wrote:
> diff --git a/Documentation/security/lsm.rst b/Documentation/security/lsm.rst
> index 6a2a2e973080..fd4c87358d54 100644
> --- a/Documentation/security/lsm.rst
> +++ b/Documentation/security/lsm.rst
> @@ -129,3 +129,31 @@ to identify it as the first security module to be registered.
>  The capabilities security module does not use the general security
>  blobs, unlike other modules. The reasons are historical and are
>  based on overhead, complexity and performance concerns.
> +
> +LSM External Interfaces
> +=======================
> +
> +The LSM infrastructure does not generally provide external interfaces.
> +The individual security modules provide what external interfaces they
> +require.
> +
> +The file ``/sys/kernel/security/lsm`` provides a comma
> +separated list of the active security modules.
> +
> +The file ``/proc/pid/attr/display`` contains the name of the security
> +module for which the ``/proc/pid/attr/current`` interface will
> +apply. This interface can be written to.
> +
> +The infrastructure does provide an interface for the special
> +case where multiple security modules provide a process context.
> +This is provided in compound context format.
> +
> +-  `lsm\0value\0lsm\0value\0`
> +
> +The `lsm` and `value` fields are nul terminated bytestrings.

Preferably                          NUL-terminated

> +Each field may contain whitespace or non-printable characters.
> +The nul bytes are included in the size of a compound context.

       NUL

> +The context ``Bell\0Secret\0Biba\0Loose\0`` has a size of 23.
> +
> +The file ``/proc/pid/attr/context`` provides the security
> +context of the identified process.


thanks.
-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
