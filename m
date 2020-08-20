Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02F124BBAF
	for <lists+linux-api@lfdr.de>; Thu, 20 Aug 2020 14:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbgHTMcm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Aug 2020 08:32:42 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.168]:30612 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730002AbgHTMcb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Aug 2020 08:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1597926745;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=HiSYPKMGXm6jn1TcY+F4FDv3aSG6bNhGXRIYvbK5L3s=;
        b=IPBS35bR14M/OsrQYLF1dvXVvVUNBmVYCHz2Zm06eq1JJB1IE0kO6+0gtTHQSrAQm3
        p35bs1o0l0BYVtCwzTFUMTyZw2pG4jom/p3co/0pwgDsOLc7Bhx6ny8cjOt05SDn7e6k
        WvOVMBAVexRbcN77MSOvpfY6gRwYljzpkob/9Gojc+ZblKzX5W7engsV4uUiCF0STZO/
        GZ7o0voBW7njz5zlktzQwIWAIFZjGR2rrrdYYMgboYZ9qz46Hyl0p9J++Q/PAEJsWzGB
        JGexzMriTV4BzvadwaC1cpHWwqia/RWAoirA/dnzdInkf6YkhAlpYdKi0tr2vexJLk2+
        n3wQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xm0dNS3IdRAZAL+p6A=="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id 002e9aw7KCVWDBa
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 20 Aug 2020 14:31:32 +0200 (CEST)
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
Subject: Re: [PATCH v32 01/12] Linux Random Number Generator
Date:   Thu, 20 Aug 2020 14:31:31 +0200
Message-ID: <3318076.iIbC2pHGDl@positron.chronox.de>
In-Reply-To: <202008201950.Peepx4LA%lkp@intel.com>
References: <7836955.NyiUUSuA9g@positron.chronox.de> <202008201950.Peepx4LA%lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Donnerstag, 20. August 2020, 13:46:49 CEST schrieb kernel test robot:

Hi,

> All warnings (new ones prefixed by >>):
> >> drivers/char/lrng/lrng_interfaces.c:120:6: warning: no previous prototype
> >> for 'add_hwgenerator_randomness' [-Wmissing-prototypes]
>      120 | void add_hwgenerator_randomness(const char *buffer, size_t count,
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~~

Thank you, added <linux/hw_random.h>
> >> 
> >> drivers/char/lrng/lrng_interfaces.c:297:6: warning: no previous prototype
> >> for 'get_random_bytes_full' [-Wmissing-prototypes]
>      297 | void get_random_bytes_full(void *buf, int nbytes)
> 
>          |      ^~~~~~~~~~~~~~~~~~~~~
> 
Thanks, added prototype to header file.

Ciao
Stephan


