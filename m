Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101AF1AB8D3
	for <lists+linux-api@lfdr.de>; Thu, 16 Apr 2020 08:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436700AbgDPG4z (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Apr 2020 02:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436660AbgDPG4w (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Apr 2020 02:56:52 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D697C061A0C;
        Wed, 15 Apr 2020 23:56:52 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k18so1021635pll.6;
        Wed, 15 Apr 2020 23:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qj5kgZ4ZycbAqsn/p7zs9dZ6xqHz+7ARuIFuoD3k3CY=;
        b=N5/wr5Fco2wljHjzliXhvFmJFSotzjTFEMHU8zVUulMJEDhDXIHq9CIHwmHxHaH1CD
         z+CXoBgEmlkGkAoGSWygBuZTlHHllwi7KDdOk6xxawYdmStZuuGaZIf7OM8pw8LCxyZe
         CO5OnPub9PZcWklFTXogbCupMm9ZShRarCfm+OibotImuwf1xq+W+s7M2CwzkgzdQAh4
         sZ1RZFLmo50L7IjL9LTDMy2Wz5Z932Yaj0M4k/aMXyANPni2DO3C9BV9D7yrWDc9EaaW
         31WvtvAtSHnXIENA/e0D4fFt3qZ0MiGVYWxMaJT0MmO9StHKUrIRS7M/LBczcjSQZSka
         j8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qj5kgZ4ZycbAqsn/p7zs9dZ6xqHz+7ARuIFuoD3k3CY=;
        b=YLUVj1Gn5TAtFwOit3trlpQn+A+CovBA3KRyVhVvwhmX091JJyyF/hH83Zvv8SZJ8V
         UiG+vh36lJWULOnhM3GTPgwszfrUiK0rpM5NMrYy7nMBYJTJgE39HzGKOtEZ5Wbt8goa
         OfW0YeiMw+HRGNUKycd5z6DWlnY1U28aw0TteT4ABlWp66JirF2ktTYA+800PgH7fT5B
         nIrTRqiqy8oVFz5QI/xw0XNSergfzeszHonPbNNe4AvbxSSvMJO6QPpybbU1RFCodBhs
         wfqcz2ShRsoZyOEaFO27yOggZxYl3e0xf2l3wnARW4c8Y11pe/VoXV1ywPH30vf6KrPX
         xkDg==
X-Gm-Message-State: AGi0PuZ3tuhNfilJcLBWAa9ZhUIUynzRUf4IadKz23kCV5CGkgNOkNl+
        51rDQ9ElAAG+iOFTOCjHejI=
X-Google-Smtp-Source: APiQypLG4TJ+NW7W0Hjp0IMS5gRAiLqoRQrHx2kNg1LBi9nBaICMZv3bqdiBtF8K4/JmGe1+OecfnQ==
X-Received: by 2002:a17:902:cf87:: with SMTP id l7mr8998414ply.307.1587020211294;
        Wed, 15 Apr 2020 23:56:51 -0700 (PDT)
Received: from gmail.com ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id v4sm15818108pfb.31.2020.04.15.23.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 23:56:50 -0700 (PDT)
Date:   Wed, 15 Apr 2020 23:56:48 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH v2] timens: show clock symbolic names in
 /proc/pid/timens_offsets
Message-ID: <20200416065648.GA801745@gmail.com>
References: <96bedbaf-49ea-f24b-b7b1-fb9a57fb6c7d@gmail.com>
 <20200411154031.642557-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200411154031.642557-1-avagin@gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Apr 11, 2020 at 08:40:31AM -0700, Andrei Vagin wrote:
> Michael Kerrisk suggested to replace numeric clock IDs on symbolic
> names.
> 
> Now the content of these files looks like this:
> $ cat /proc/774/timens_offsets
> monotonic      864000         0
> boottime      1728000         0
> 
> For setting offsets, both representations of clocks can be used.
> 
> As for compatibility, it is acceptable to change things as long as
> userspace doesn't care. The format of timens_offsets files is very
> new and there are no userspace tools that rely on this format.
> 
> But three projects crun, util-linux and criu rely on the interface of
> setting time offsets and this is why we need to continue supporting the
> clock IDs in this case.
> 
> Fixes: 04a8682a71be ("fs/proc: Introduce /proc/pid/timens_offsets")
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> Acked-by: Michael Kerrisk <mtk.manpages@gmail.com>                                                                                                                                            

Thomas and Andrew, could you merge this patch? I am sorry, I used the
wrong subsystem prefix. Let me know if I need to send the third version
of this patch.

Thanks,
Andrei
