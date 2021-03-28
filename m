Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135CC34BF1C
	for <lists+linux-api@lfdr.de>; Sun, 28 Mar 2021 22:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhC1Uyn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 28 Mar 2021 16:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhC1UyM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 28 Mar 2021 16:54:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F615C0613B1
        for <linux-api@vger.kernel.org>; Sun, 28 Mar 2021 13:54:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o16so10875880wrn.0
        for <linux-api@vger.kernel.org>; Sun, 28 Mar 2021 13:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uUUE0tRysCl/AZmYpBE7nB+xaBTY+Blnl2TRorK4CnE=;
        b=K/gEePEDOzCnjIelkn1fH5ent6cwQvRSdL9xWz2JB4u9smCm8AgkmljP8Nt2AIQMzz
         UTJyQzBCSOQN5aWJaaM55iUE1zdr8cxuD05IjrYdn5sC01T7yZ2MnLTpPFDavu46vBHr
         qG3yqCsa9ldF/lZYyhqvj3xipK/Db4AgEx6rUJW0wFqrYYnC1j+BqSXBNJk/g3OC3lwl
         5aP1RiKSBqiwaWCDkDBsQqiQhSXyvHV6z79L+xGyRmjxmxQbJKxQfUioGMg5i4n27Hca
         BI6kKvsxDdSEgzQCuBnekyoiLeOfv6dD58KiiyQGvHgWdsLe2xN6wlpRk1RKWuRXzGt6
         ol5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uUUE0tRysCl/AZmYpBE7nB+xaBTY+Blnl2TRorK4CnE=;
        b=LTRMlhSfe465hhVfT0Eu75TNQcIi2sEqP7zMt0h19ye5zlRcVYaktvbThbO2/mqn5i
         Tk7K+oZVWWt/eykZxbj0GOK4kX/suBtHLGLOzWJcUtOOd1xiLej5L3fCWhmigt2AqgNf
         qflCwFlwn9mO1u0X5vx3TA1Nn01/rfkCIcX7ibnfM22vIUEvmLtH2d02cDs/DxkEFTjR
         9t5ARATpMt1L3beEt7mRSq5a0CEJUsbEaG/7JoSrpugLJyHqjmi7ofOw3C6MjDRt6oc/
         WBQXDRgkUC45QG9z0M1YnbgblEzse4z9jjaej2vZpFGZR1eqKFg2Q0x6N86UAtR8R0sj
         MpEw==
X-Gm-Message-State: AOAM533sa4luxsgfrH6DiiZmm493ecHELSSTsJZwRdKQWe53zfwH80xh
        XPJE9r/tGOLKzBhyT83Uq6ED1aiQRvhY4g==
X-Google-Smtp-Source: ABdhPJw/+473E5al27E6cQcqeHyl/jgUQtowDCwkSE4Ne4syo7zVokG2CEjHrtXgV/DHDlUKpZ/eKA==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr26144466wrk.146.1616964849655;
        Sun, 28 Mar 2021 13:54:09 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:1945:696f:a453:cac9? ([2a01:e34:ed2f:f020:1945:696f:a453:cac9])
        by smtp.googlemail.com with ESMTPSA id p14sm21920580wmc.30.2021.03.28.13.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 13:54:09 -0700 (PDT)
Subject: Re: [PATCH] thermal/drivers/netlink: Add the temperature when
 crossing a trip point
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rkumbako@quicinc.com, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ABI/API" <linux-api@vger.kernel.org>
References: <20210325193633.19592-1-daniel.lezcano@linaro.org>
 <CAJZ5v0g58LMVwRWdJaTWVOx09gt6KRGTa974k3cvHYQyxk0EYg@mail.gmail.com>
 <444a7fc72e6525575b929760fcad186630577afc.camel@linux.intel.com>
 <ae16d810-e5ec-ad63-7b29-fd1ddab68907@linaro.org>
 <a2665d9f450b5e6dc0cc5017e2b83a5c49840d3f.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2fa60fba-e904-62c1-9b9c-9e05a877c050@linaro.org>
Date:   Sun, 28 Mar 2021 22:54:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a2665d9f450b5e6dc0cc5017e2b83a5c49840d3f.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 28/03/2021 21:31, Srinivas Pandruvada wrote:
> Hi Daniel,

[ ... ]

>> I don't see where is the problem. The protocol is still compatible
>> with
>> the previous version, so that does not break the existing AFAICT.
>> That
>> is done on purpose.
> 
> The size of netlink message is changed. This is not a good argument to
> just adding members at the end. The point I am trying that netlink now
> is an ABI, which should go through same process as we are
> adding/changing a sysfs attributes.
>  

Ok I understand your point. I will provide a description in
Documentation/ABI/testing, something I should have done before and take
the opportunity to provide a bigger update of the thermal netlink
messages with more commands.

Thanks
  -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
