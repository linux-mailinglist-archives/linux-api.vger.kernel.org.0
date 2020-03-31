Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A01FE199895
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2020 16:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbgCaObk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 31 Mar 2020 10:31:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42322 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730810AbgCaObk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 31 Mar 2020 10:31:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id 22so10398519pfa.9;
        Tue, 31 Mar 2020 07:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZV1KfwgGLtoEiy3TkAg/zZ6KIB+b40AZeOP0Q0XHWHU=;
        b=V/ckHBGkUv+faIurBZm6aWkZw8kSgZv/W32v4KnRdHa3ae4XdBHYzRPzrKlm7N82wq
         6tazVl/vkU+thJE5va34cOiRLqXI+R3LequulATdCwnwje5A/mPVtrJnOyq4p3pf+N9S
         6uWJsnj/KTpQ1pK/7N4Q+NxBYqFyKHZkQdcOF0mhY4JoKZyZWXFW2Ndgx2WFDfwdP7BJ
         MWVTD+PhVu28Po06FEONOF8zzI2Aj4+b5+JgzeW01tA5XH5tqXtmeLUAUSeVh5znX8tv
         nuwpsyj7NAZxrbSl1bRHfMPNFXEo8WFUJSSR/58GUmp2BhDV82HXg3nLf+31df9865qf
         SKrg==
X-Gm-Message-State: ANhLgQ32zP88vMIDbn+syR3TVqKLMyTETGr3z6aXJ7+BTrJztNOUYEjX
        VrYUXRNssY1JKm3NBQ5+tmA=
X-Google-Smtp-Source: ADFU+vv9QG+JNLAPq5Hse2+XL1fqy/ETctrMBCrfQRW4WYOaoKGlkutwe7Dhv7pKCEUfjkAs3IExyg==
X-Received: by 2002:a63:7e10:: with SMTP id z16mr18195431pgc.412.1585665098929;
        Tue, 31 Mar 2020 07:31:38 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 184sm469375pge.71.2020.03.31.07.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 07:31:35 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 0DA0940277; Tue, 31 Mar 2020 14:31:35 +0000 (UTC)
Date:   Tue, 31 Mar 2020 14:31:35 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 1/3] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-ID: <20200331143134.GY11244@42.do-not-panic.com>
References: <20200330115535.3215-1-vbabka@suse.cz>
 <20200330115535.3215-2-vbabka@suse.cz>
 <20200330224422.GX11244@42.do-not-panic.com>
 <8146e3d0-89c3-7f79-f786-084c58282c85@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8146e3d0-89c3-7f79-f786-084c58282c85@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 31, 2020 at 09:42:46AM +0200, Vlastimil Babka wrote:
> On 3/31/20 12:44 AM, Luis Chamberlain wrote:
> > 
> > This is wonderful when we think about existing sysctls which have
> > corresponding silly boot params that do the same thing. However, shoving
> > a boot param capability down every possible built-in sysctl brings
> > forward support considerations we should take serious, as this would
> > add a new user interface and we'll have to support it.
> 
> Hmm, if I boot with an initramfs with init process that does mount /proc and set
> some sysctl there as the very first thing, then this will be almost the same
> moment as my patch does it. There is no further kernel initialization in
> between. So with your logic we already do support all non-modular sysctls to be
> set so early.

Yes, true. Then by all means:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
