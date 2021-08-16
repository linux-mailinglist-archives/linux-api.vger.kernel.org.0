Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750C03ECDE7
	for <lists+linux-api@lfdr.de>; Mon, 16 Aug 2021 07:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhHPFEG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 16 Aug 2021 01:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhHPFEF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Aug 2021 01:04:05 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276D5C061764
        for <linux-api@vger.kernel.org>; Sun, 15 Aug 2021 22:03:35 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id w14so24564213pjh.5
        for <linux-api@vger.kernel.org>; Sun, 15 Aug 2021 22:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G0FDtIMfLpNbCJZ4VkpckuNvikaSN4A0fZUcwO8aW2A=;
        b=BVbolKMQAGpnV4kZ03/DYFBiVkcmZagBmMd6aKH4qcEe6J/uZf/bXIGHdUzERNkwov
         Ap3dcmIlCPYD8qG3tvlB84YPU6IxvEN/Ljphq706feNaE5ghpW7i4+2KFC62rUclFYge
         KQe3uMV9gSnVjbxv1FdKYuaCAHxIJtKto2enO9K2Gy4Txd42629+CKhTDhS/9ARvPciB
         aW1NGPDb/kJhl2HqFVInjUlQiMlXYJbJAmBh2WSh8yIpqR0Bj23s02tGkUx2UxjuoOdJ
         4kizOGczBnAA1O+7pDp45yhd7QFE6yN2R+BzXIJpWqKzJ640v4DDKekBj+f7MpJ1kD2X
         yVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G0FDtIMfLpNbCJZ4VkpckuNvikaSN4A0fZUcwO8aW2A=;
        b=DTeslKf6RDN15s+Uq4uJuzv88ju01Twm6Czbdp0NioTBC30NBCVHEhYZk6EMHqz9WP
         voasEnLDsB/jrNmvgrDttYwXScpRl8tHhvy0+hfkd8W8PetIf3PTO0kPGJJPJV0vrWEB
         EOQ61rwac1rQx+iKIao6BbDMUeM7zamr6OFfJbsRlEXfEbdDFEZjzTgBJ2/pKhaznyN3
         fNf5VizxyQnzQvPR/GmFpTAF8IHIltKl0ktWocVgb9RxVX0JqaU2O90QILA87L8btLcQ
         ENVqf/4EEODXf0n7v8/GAd4x9hnSRHYzNsbC5IZu+lXOsHc1mhW8NFi4QLOOgjZH0aBK
         z5/Q==
X-Gm-Message-State: AOAM532FyPljtSC5XH5SUWQW38a3dBHIOakfA2UoTzzeRk1/tA3CvvTp
        wq+0ZS3lmhQQqW09FMErlk6bqpJbzHEWzQ==
X-Google-Smtp-Source: ABdhPJx8/Nxjzkjug91UFk98u1oZB05hYYWjCYLRAs6aTq2Fd/zBm9w+iu4VTz8AEA9ULOWY+bHWPA==
X-Received: by 2002:a65:670f:: with SMTP id u15mr14148221pgf.205.1629090214334;
        Sun, 15 Aug 2021 22:03:34 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:2d6c:8736:2020:8925])
        by smtp.gmail.com with ESMTPSA id u62sm9942538pfb.19.2021.08.15.22.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 22:03:33 -0700 (PDT)
Date:   Mon, 16 Aug 2021 15:03:19 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Jan Kara <jack@suse.cz>
Cc:     amir73il@gmail.com, christian.brauner@ubuntu.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Add pidfd support to the fanotify API
Message-ID: <YRnxl1wKImPQSUpy@google.com>
References: <cover.1628398044.git.repnop@google.com>
 <20210810113348.GE18722@quack2.suse.cz>
 <YRMmYWHSno/IGhTN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRMmYWHSno/IGhTN@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hey Jan,

On Wed, Aug 11, 2021 at 11:22:41AM +1000, Matthew Bobrowski wrote:
> On Tue, Aug 10, 2021 at 01:33:48PM +0200, Jan Kara wrote:
> > Hello Matthew!
> > 
> > On Sun 08-08-21 15:23:59, Matthew Bobrowski wrote:
> > > This is V5 of the FAN_REPORT_PIDFD patch series. It contains the minor
> > > comment/commit description fixes that were picked up by Amir in the
> > > last series review [0, 1].
> > > 
> > > LTP tests for this API change can be found here [2]. Man page updates
> > > for this change can be found here [3].
> > > 
> > > [0] https://lore.kernel.org/linux-fsdevel/CAOQ4uxhnCk+FXK_e_GA=jC_0HWO+3ZdwHSi=zCa2Kpb0NDxBSg@mail.gmail.com/
> > > [1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxgO3oViTSFZ0zs6brrHrmw362r1C9SQ7g6=XgRwyrzMuw@mail.gmail.com/
> > > [2] https://github.com/matthewbobrowski/ltp/tree/fanotify_pidfd_v2
> > > [3] https://github.com/matthewbobrowski/man-pages/tree/fanotify_pidfd_v1
> > > 
> > > Matthew Bobrowski (5):
> > >   kernel/pid.c: remove static qualifier from pidfd_create()
> > >   kernel/pid.c: implement additional checks upon pidfd_create()
> > >     parameters
> > >   fanotify: minor cosmetic adjustments to fid labels
> > >   fanotify: introduce a generic info record copying helper
> > >   fanotify: add pidfd support to the fanotify API
> > 
> > Thanks! I've pulled the series into my tree. Note that your fanotify21 LTP
> > testcase is broken with the current kernel because 'ino' entry got added to
> > fdinfo. I think having to understand all possible keys that can occur in
> > fdinfo is too fragile. I understand why you want to do that but I guess the
> > test would be too faulty to be practical. So I'd just ignore unknown keys
> > in fdinfo for that test.
> 
> Excellent, for merging these changes!
> 
> In regards to the LTP test (fanotify21), at the time of writing I had also
> shared a similar thought in the sense that it was too fragile, but wrongly
> so I weighed up my decision based on the likelihood and frequency of fields
> being changed/added to fdinfo. I was very wrong...
> 
> Anyway, I will fix it so that any "unknown" fields are ignored.

FWIW, I've dropped that last else statement in the
parse_pidfd_fdinfo_line() helper in LTP fanotify21. An updated branch has
been pushed here [0].

[0] https://github.com/matthewbobrowski/ltp/commits/fanotify_pidfd_v3

/M
