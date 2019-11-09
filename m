Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D31BAF5F0C
	for <lists+linux-api@lfdr.de>; Sat,  9 Nov 2019 13:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfKIM1e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Sat, 9 Nov 2019 07:27:34 -0500
Received: from albireo.enyo.de ([37.24.231.21]:37196 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfKIM1e (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 9 Nov 2019 07:27:34 -0500
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iTPpz-0002st-6l; Sat, 09 Nov 2019 12:27:31 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1iTPpz-0003iE-0T; Sat, 09 Nov 2019 13:27:31 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Elichai Turkel <elichai.turkel@gmail.com>
Cc:     Christian Brauner <christian@brauner.io>,
        linux-api@vger.kernel.org, libc-alpha <libc-alpha@sourceware.org>
Subject: Re: Missing size_t declaration in UAPI
References: <CALN7hCJRe1uL6pd+VwgzDt=5giMVjvX+YpF28f5qbLOVCZf4GQ@mail.gmail.com>
        <04EB5627-FD42-4397-995B-FDF051CFCFB5@brauner.io>
        <CALN7hC+YmHGpniNKBiD03cBnTyO+cqXhrVvE7SdtgEb7GkG-LQ@mail.gmail.com>
Date:   Sat, 09 Nov 2019 13:27:30 +0100
In-Reply-To: <CALN7hC+YmHGpniNKBiD03cBnTyO+cqXhrVvE7SdtgEb7GkG-LQ@mail.gmail.com>
        (Elichai Turkel's message of "Sat, 9 Nov 2019 13:52:11 +0200")
Message-ID: <87d0e19qvh.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Elichai Turkel:

> I'm proposing to move `linux/tools/include/nolibc/nolibc.h` to the
> UAPI interface.
> It would then be included in `linux/types.h`
> Would love feedback before I work on a patch.

I do not think nolibc.h is a good starting point.  The header is
pretty much incompatible with everything, including multiple
translation units that include it, so including it from
<linux/types.h> will not work.

>>> Currently compiling the following program fails:
>>> ```
>>> #include "linux/signal.h"
>>> void main(void){}
>>> ```
>>> Because of `./asm/signal.h:127:2: error: unknown type name ‘size_t’`.
>>>
>>> I tried patching with `#include <stddef.h>` but there's a local file
>>> with the same name overriding the include.

<stddef.h> is expected to be provided by the compiler. It's probably
easier to fix your build environment.
