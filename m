Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2727BEBC0
	for <lists+linux-api@lfdr.de>; Mon,  9 Oct 2023 22:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbjJIUjY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Oct 2023 16:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbjJIUjW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 9 Oct 2023 16:39:22 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128459E
        for <linux-api@vger.kernel.org>; Mon,  9 Oct 2023 13:39:21 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c724577e1fso39323115ad.0
        for <linux-api@vger.kernel.org>; Mon, 09 Oct 2023 13:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696883960; x=1697488760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6th8j9k2Pe6baZ3T+hOaDAZYRZhrApdfI4UqgTmaNzs=;
        b=X8IJlrRygR144Gh5KnY2qPN1xK0Nth5Q2WG67OkObOJUjwHOtFs11P5LPYl8nl3ivZ
         4jmuhz87aW36LN5YBQXLWHcW7e9hby50mgZZguTCD4LamktiQr+pY8qiANgiIjNmPtDx
         65qImMUZ1tVWwk2Xx/uBNH+iV1ka4y5k+By3wyLu53bK6zrMXA0O33nxBI0hAaRdPx9P
         qJ2nAhHxgWl++ra2HewQdbq4w5jIOlEOzV8YC6MdiMgjLQrRdeoJu8kuaKsjioAj4aC/
         MIkdCE3FcuL6ZLTIsQUdltLmSkOC+bPP9rht05JLXNOda8s1i41msjB19H+Dpg653HxX
         0opQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696883960; x=1697488760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6th8j9k2Pe6baZ3T+hOaDAZYRZhrApdfI4UqgTmaNzs=;
        b=CmdZDSchSRdgcPISUgyzkD5xWFEzE/pN61E578tS4lB7lzfHPY8bGNPq1SYk2pC4H4
         01GOAb6k3YRDFFSR8OPGQnJsUs7zuI/pLp+wDR9u7AeMG7KpcCc9VF9/QF1Vd9QtgaLr
         rEEHqHKUd9+KeMl6ImfDcd3cNt+AyhsSkrLRudkc7j7PUtTox86B7xDh4XmDzDa9l+Oe
         2pX/yElJQCuc1y/gOU4tQZQIoi80umGgqGbThwy3fObMTsWWSxsvXHrF2xkUS1gMFlD0
         f75z2/8oyLy0cH6c+ZSjAU6MdjAEvySiwl+9Gra1vNr5ShXLIBxrLfLNywHpBgHd8ezx
         ssqw==
X-Gm-Message-State: AOJu0YzkBwTyfIOCGh5sSwd7DWhsYS8RJnbHZUl2U61mvlxz9XGlz6AM
        sQthJzQ5uH81Qr3dl/tnyr4BVQ==
X-Google-Smtp-Source: AGHT+IHz77Mwe4h7mpzLokn4q+wV6v+0Pr/UTJLJZIPiKv/oKCSBZeaaSBLN5sMSryT9iTtw5m3rYA==
X-Received: by 2002:a17:903:1c8:b0:1c8:a63a:2087 with SMTP id e8-20020a17090301c800b001c8a63a2087mr5691413plh.65.1696883960472;
        Mon, 09 Oct 2023 13:39:20 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id h19-20020a170902f7d300b001b86492d724sm10072201plw.223.2023.10.09.13.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 13:39:19 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qpx25-00Bfxr-22;
        Tue, 10 Oct 2023 07:39:17 +1100
Date:   Tue, 10 Oct 2023 07:39:17 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     John Garry <john.g.garry@oracle.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, martin.petersen@oracle.com,
        himanshu.madhani@oracle.com
Subject: Re: [PATCH 2/4] readv.2: Document RWF_ATOMIC flag
Message-ID: <ZSRk9Z6/i2E+YV9A@dread.disaster.area>
References: <20230929093717.2972367-1-john.g.garry@oracle.com>
 <20230929093717.2972367-3-john.g.garry@oracle.com>
 <20231009174438.GE21283@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009174438.GE21283@frogsfrogsfrogs>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Oct 09, 2023 at 10:44:38AM -0700, Darrick J. Wong wrote:
> On Fri, Sep 29, 2023 at 09:37:15AM +0000, John Garry wrote:
> > From: Himanshu Madhani <himanshu.madhani@oracle.com>
> > 
> > Add RWF_ATOMIC flag description for pwritev2().
> > 
> > Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> > #jpg: complete rewrite
> > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > ---
> >  man2/readv.2 | 45 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
....
> > +For when regular files are opened with
> > +.BR open (2)
> > +but without
> > +.B O_SYNC
> > +or
> > +.B O_DSYNC
> > +and the
> > +.BR pwritev2()
> > +call is made without
> > +.B RWF_SYNC
> > +or
> > +.BR RWF_DSYNC
> > +set, the range metadata must already be flushed to storage and the data range
> > +must not be in unwritten state, shared, a preallocation, or a hole.
> 
> I think that we can drop all of these flags requirements, since the
> contiguous small space allocation requirement means that the fs can
> provide all-or-nothing writes even if metadata updates are needed:
> 
> If the file range is allocated and marked unwritten (i.e. a
> preallocation), the ioend will clear the unwritten bit from the file
> mapping atomically.  After a crash, the application sees either zeroes
> or all the data that was written.
> 
> If the file range is shared, the ioend will map the COW staging extent
> into the file atomically.  After a crash, the application sees either
> the old contents from the old blocks, or the new contents from the new
> blocks.
> 
> If the file range is a sparse hole, the directio setup will allocate
> space and create an unwritten mapping before issuing the write bio.  The
> rest of the process works the same as preallocations and has the same
> behaviors.
> 
> If the file range is allocated and was previously written, the write is
> issued and that's all that's needed from the fs.  After a crash, reads
> of the storage device produce the old contents or the new contents.

This is exactly what I explained when reviewing the code that
rejected RWF_ATOMIC without O_DSYNC on metadata dirty inodes.

> Summarizing:
> 
> An (ATOMIC|SYNC) request provides the strongest guarantees (data
> will not be torn, and all file metadata updates are persisted before
> the write is returned to userspace.  Programs see either the old data or
> the new data, even if there's a crash.
> 
> (ATOMIC|DSYNC) is less strong -- data will not be torn, and any file
> updates for just that region are persisted before the write is returned.
> 
> (ATOMIC) is the least strong -- data will not be torn.  Neither the
> filesystem nor the device make guarantees that anything ended up on
> stable storage, but if it does, programs see either the old data or the
> new data.

Yup, that makes sense to me.

> Maybe we should rename the whole UAPI s/atomic/untorn/...

Perhaps, though "torn writes" is nomenclature that nobody outside
storage and filesystem developers really knows about. All I ever
hear from userspace developers is "we want atomic/all-or-nothing
data writes"...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
