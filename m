Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79AA24BB68
	for <lists+linux-api@lfdr.de>; Thu, 20 Aug 2020 14:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbgHTM2j (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Aug 2020 08:28:39 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:25628 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729745AbgHTM2a (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Aug 2020 08:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1597926505;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=/JloQPp9h4GmQtbfm5NHu/X6KBfEz5eiI1yrNGZEv0A=;
        b=h4qmX/sOMAbRIXJ7Y/NUhUCi9TLU/i5EkQHgzS8mgOSM5UP0VQmRvsKo2Qp9iJspSW
        mf8T6k1CtetBcW5GZQe/SLRL3G5P2AWjmbXVcayXCjr7+LgCgTbzhma5L6cMoeaVt+YY
        VKrmitwvVjsVhuD3ekXhQNjTNWDMSmRHSbr9VcycNDRXy6L2C19B0TH4jFrfEtBC46rl
        BNQKg8eOHWOX0Q1pVd4SO+0l4Kyn5gpAsWRplEbwI0GblzIYr8wKO+NXrv+qMI6BUno/
        aCJNLlxaMiUVo98Pso9HwqmbK3lSjSgnmL7m/xEaMAbzNODXgFAKXoFYocGuZZ42AOSP
        Unxg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xm0dNS3IdRAZAL+p6A=="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id 002e9aw7KCRYD9R
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 20 Aug 2020 14:27:34 +0200 (CEST)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH v32 06/12] LRNG - add SP800-90A DRBG extension
Date:   Thu, 20 Aug 2020 14:27:33 +0200
Message-ID: <20755167.EfDdHjke4D@positron.chronox.de>
In-Reply-To: <202008202008.JfY8S1sB%lkp@intel.com>
References: <1733393.atdPhlSkOF@positron.chronox.de> <202008202008.JfY8S1sB%lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Donnerstag, 20. August 2020, 14:07:40 CEST schrieb kernel test robot:

Hi,

> 
> All warnings (new ones prefixed by >>):
> >> drivers/char/lrng/lrng_drbg.c:226:1: warning: 'static' is not at
> >> beginning of declaration [-Wold-style-declaration]
>      226 | const static struct lrng_crypto_cb lrng_drbg_crypto_cb = {
> 
>          | ^~~~~

Thanks, I will provide a new patch set with the two keywords switched.

Ciao
Stephan


