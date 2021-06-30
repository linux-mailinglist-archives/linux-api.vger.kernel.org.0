Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BA13B8834
	for <lists+linux-api@lfdr.de>; Wed, 30 Jun 2021 20:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbhF3SPb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Jun 2021 14:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhF3SPa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 30 Jun 2021 14:15:30 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2C7C061756
        for <linux-api@vger.kernel.org>; Wed, 30 Jun 2021 11:13:00 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id y9so2128273qtx.9
        for <linux-api@vger.kernel.org>; Wed, 30 Jun 2021 11:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EOqaGkrKg1sXqmL4wZsaueCQStRTA7u5d9+19LTY1k0=;
        b=2SAJM+uBZ/9ny1XIgt3/1LTNEEb8POWeI3R+LE25j9m6ZxXKVALj7n2H6/22/7A5MC
         io3htUXpUPheNzVK+ZXLQah9jpNjKZXtBJVrVbokE59c/IMvWg+2pywf4Gf3MprrX5MX
         rmNg5tF2fLn5ITofpNGeiD5aOE+lGoiR7EVXOBkxNzLSgC2apsRRXouSOuvOPrL8VyRJ
         eyDui6MxFAMbt4DMdIwhJ6HcP4ZEfa/3FuKx0wcwU5NEAKCZsQ8K3QCwMPpFLQJ49CcW
         MIaDTJ8RQbynNgDteDr5k0FHFi8mP04BAmM+4NqUrSnMjqR653vIIQog2gDi1jY1gX4z
         wcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EOqaGkrKg1sXqmL4wZsaueCQStRTA7u5d9+19LTY1k0=;
        b=DUgimrjD6HZSrGs604p3l/JFmCgTyeGgjrmXw1ks9wCUMA/cdyBnz3eICguNcDwh+X
         nelzNGHa7C1bkjgkqeOcTfB7epJ+/mmz76QMzC8zUQ+r2kw6iWnGmWgSEaolRyqUSoda
         HN9Ef9bqX2TYvlOx0BHUiCXPiMEnPFJ39Yo2nekPSZPwNCoNw6uL5Q+hH4GfwHZMYKmj
         elfcRQt1wzlksPOIRTb44U06SYetqTiaHcPNCOZKF0nZZSv12YP3aU8eBGYruWD/fymS
         oTNIm9SuT7Xa8Ml6FiIP30XGyUPZOQwWima7ETzAXKd9nj3zD+xxCdulH5Q42gqsYlH1
         Z2XA==
X-Gm-Message-State: AOAM5315Ot2oNv1JYRvR6YkzvIxJnapBVloIp0ZZeCbycxk2STGJ5fLr
        McJyZl2qRT7pNmVQOODGI/Ba+A==
X-Google-Smtp-Source: ABdhPJz6jWKNH+dWOTW5h2fjCggfRSfbOEXpOljbYc0ETReRgSj4WY1xMBxSbViuyAhP2zIq9Yj5pg==
X-Received: by 2002:ac8:6044:: with SMTP id k4mr5480203qtm.149.1625076779203;
        Wed, 30 Jun 2021 11:12:59 -0700 (PDT)
Received: from ?IPv6:2607:fb90:c2d6:b7c1:6680:99ff:fe6f:cb54? ([2607:fb90:c2d6:b7c1:6680:99ff:fe6f:cb54])
        by smtp.gmail.com with ESMTPSA id i19sm4994092qkl.19.2021.06.30.11.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 11:12:58 -0700 (PDT)
Subject: Re: lsattr: incorrect size for ioctl result
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     Denys Vlasenko <vda.linux@googlemail.com>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
References: <CAK1hOcO3qHFO6QOkpjnC_A4LVhwed02XxCYZvEn+8t+HnyGjZA@mail.gmail.com>
 <b1b801af-d309-829e-fd48-6487661df809@landley.net>
 <CAK1hOcMh3RK_Nd_=W-RgqhMZJh-OGY9qMDfxpALZHpxwriHgAA@mail.gmail.com>
 <9acca2fa-eaef-1a0b-ac72-6b0eab3d8a45@landley.net> <YNn5v7CTRsDo1mDO@mit.edu>
 <b5f013f0-7720-e6fb-f512-c1ff7114dfb6@landley.net> <YNs7KsXJLdPp78Q5@mit.edu>
 <20210629210422.GD13767@locust>
From:   Rob Landley <rob@landley.net>
Message-ID: <1ff54887-c1bc-0f30-c750-eef41e8a2a35@landley.net>
Date:   Wed, 30 Jun 2021 13:30:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629210422.GD13767@locust>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 6/29/21 4:04 PM, Darrick J. Wong wrote:
> Why don't we deprecate FS_IOC_[GS]ETFLAGS and tell everyone to use
> FS[GS]ETXATTR?  They use the same code paths and vfs helpers now.

How does "invent a new API and tell everybody to use that instead" address a
concern about a least intrusive cleanup while maintaining binary compatibility
with historical weirdness?

(There IS a currently consistent API. It's the "32" versions. The surprise is
that the non-32 versions don't do something different than the 32 versions, even
though their definition implies they would.)

Rob
