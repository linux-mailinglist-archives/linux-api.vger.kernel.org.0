Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4DB3E87A2
	for <lists+linux-api@lfdr.de>; Wed, 11 Aug 2021 03:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhHKBXU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Aug 2021 21:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhHKBXT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 10 Aug 2021 21:23:19 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1ECC061765
        for <linux-api@vger.kernel.org>; Tue, 10 Aug 2021 18:22:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so2013242pjl.4
        for <linux-api@vger.kernel.org>; Tue, 10 Aug 2021 18:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wvfj8vwrt4A0hMP72Gk0ySr0IJ8+ImiWZtVOCuOcHSY=;
        b=FOYbqCxsoDMlYpiL99q9G3QZnNTKRACL84KDh4Pd2mV9mJP0edv7JgLtbYLZ6lEklU
         JA2IkJUjaAdBTizEGSZJDqQb5LZhTAYnr7E1a1FHQdXxGbaZWWCpjh7xSTidlEIhqvQt
         qPPXXaYbjU1hVypIkXou+BOavFVHcBXLWsUnkOA/d7PDlArzrHpw0dIoVMgUcfDmfYcl
         3gEaVQZsYFysgGE+MwFWUxvzOWk9tpIwH9FuKNygtHMF0h723DADORuHi5ssC6d9mziZ
         u9ScP7taIighsDxLa2+on3U3ifgKi/b9oN4Rkxye5HnEV6UBVwHQfxkHx233ehj8k6Tj
         FDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wvfj8vwrt4A0hMP72Gk0ySr0IJ8+ImiWZtVOCuOcHSY=;
        b=PEYFA6x5KiXZpkreytSgQS0KeuuFftadjcjDSiCnEVX9iqSQnCgEfv7hAM6DF4w9dr
         7CyIfIjj5MqSvmMT+1O5kjm2jMzrgL3gdb1TN4LovYERo2Mc76s36sRnVFnnPYeTNuvC
         QIul7Xfkw54NNc5IPCVFDR6twzQzJeWhfiVyssYkY36aZkzjEregdSDwtB13iBuKkAnQ
         QstH5sjzMT+T7KFwoWCxa3abOlUNM3vrf4mde1J5KapPM4K2m1ZT5+F0VsVMwQ0osAKE
         EJ0Z54ivi3/DpWl+3db7zq3oTV5y5jJMdAlSPX/smjcxouIwZ9k5MHb7nZv7wUV6Xe03
         hPIQ==
X-Gm-Message-State: AOAM5336FVba4RH4gPK1F4xbNyvJ1UQBtbiLrTYzYJ/Fb/poAb/xwMO5
        VDO+P11QZ3iipRONjNJeNnBdjg==
X-Google-Smtp-Source: ABdhPJzHxV8Z/vE0z9m4qpkACUKHoKOzNrr01UnkqxMY7HTWlOa71y7jk7StQ6IstgTzCBNr5feMRg==
X-Received: by 2002:a63:120e:: with SMTP id h14mr410653pgl.215.1628644976557;
        Tue, 10 Aug 2021 18:22:56 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:46f7:f8ea:5192:59e7])
        by smtp.gmail.com with ESMTPSA id 141sm124108pfv.15.2021.08.10.18.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 18:22:55 -0700 (PDT)
Date:   Wed, 11 Aug 2021 11:22:41 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Jan Kara <jack@suse.cz>
Cc:     amir73il@gmail.com, christian.brauner@ubuntu.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Add pidfd support to the fanotify API
Message-ID: <YRMmYWHSno/IGhTN@google.com>
References: <cover.1628398044.git.repnop@google.com>
 <20210810113348.GE18722@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810113348.GE18722@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Aug 10, 2021 at 01:33:48PM +0200, Jan Kara wrote:
> Hello Matthew!
> 
> On Sun 08-08-21 15:23:59, Matthew Bobrowski wrote:
> > This is V5 of the FAN_REPORT_PIDFD patch series. It contains the minor
> > comment/commit description fixes that were picked up by Amir in the
> > last series review [0, 1].
> > 
> > LTP tests for this API change can be found here [2]. Man page updates
> > for this change can be found here [3].
> > 
> > [0] https://lore.kernel.org/linux-fsdevel/CAOQ4uxhnCk+FXK_e_GA=jC_0HWO+3ZdwHSi=zCa2Kpb0NDxBSg@mail.gmail.com/
> > [1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxgO3oViTSFZ0zs6brrHrmw362r1C9SQ7g6=XgRwyrzMuw@mail.gmail.com/
> > [2] https://github.com/matthewbobrowski/ltp/tree/fanotify_pidfd_v2
> > [3] https://github.com/matthewbobrowski/man-pages/tree/fanotify_pidfd_v1
> > 
> > Matthew Bobrowski (5):
> >   kernel/pid.c: remove static qualifier from pidfd_create()
> >   kernel/pid.c: implement additional checks upon pidfd_create()
> >     parameters
> >   fanotify: minor cosmetic adjustments to fid labels
> >   fanotify: introduce a generic info record copying helper
> >   fanotify: add pidfd support to the fanotify API
> 
> Thanks! I've pulled the series into my tree. Note that your fanotify21 LTP
> testcase is broken with the current kernel because 'ino' entry got added to
> fdinfo. I think having to understand all possible keys that can occur in
> fdinfo is too fragile. I understand why you want to do that but I guess the
> test would be too faulty to be practical. So I'd just ignore unknown keys
> in fdinfo for that test.

Excellent, for merging these changes!

In regards to the LTP test (fanotify21), at the time of writing I had also
shared a similar thought in the sense that it was too fragile, but wrongly
so I weighed up my decision based on the likelihood and frequency of fields
being changed/added to fdinfo. I was very wrong...

Anyway, I will fix it so that any "unknown" fields are ignored.

/M
