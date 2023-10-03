Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A327B5FED
	for <lists+linux-api@lfdr.de>; Tue,  3 Oct 2023 06:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239045AbjJCEe1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Oct 2023 00:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjJCEeZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Oct 2023 00:34:25 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C175AB
        for <linux-api@vger.kernel.org>; Mon,  2 Oct 2023 21:34:22 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c724577e1fso3780125ad.0
        for <linux-api@vger.kernel.org>; Mon, 02 Oct 2023 21:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696307661; x=1696912461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+xysvb7UXDgrvMeyvIHjhvvDF8mxwwGkkX/MDtZn8IY=;
        b=S7JEE00gjWybiT6QwjW+ygdGd47CBX16/jJy0jro/5PqFdnq6nxZQp1X3w9zE9SQD5
         SvPAf2SmmGtGlI/8pPrhTlGceMP69/8Ipa9VwKamFnN+dNtYANjHLLX4C7wOGVaKLGtJ
         II3OhLEB0onFNn5CEk7Hi7UbTBY08+s/0kbhGX0EqmmemGgvMf8rplt9kC7vhfr7xgGx
         Q7eH8mGXuMO8fp4mnpCirnehS2L1VVRtIkB9TmmTYO99EoPFPKkte1s9oRRuFEJaiVbW
         LROhmnTM5kOeTZ1qhdhmKU72BLoytXKjgDCOuTZaUyrjaopILyMza4zScys6tNwv5ybJ
         2+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696307661; x=1696912461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xysvb7UXDgrvMeyvIHjhvvDF8mxwwGkkX/MDtZn8IY=;
        b=rQ7TD/rGlDk4pmQC2kV+PGr01uTG3y5DDuNdvou1yETB4pQ6zBFNWjEtYdC9RwLRKv
         Ks91d1RADH9zb1LWaMizjiowiSRksCgiQOPm99mRoXgxsDWbUyeVFHmPWfNhGuD0LA6e
         IHdzqLFAXcdYLty/UZQ7+QjXo4GQiKk5m1UEK9dbUmQXJU0QHJm1ugsHsSfzKSpUCibu
         IkZ1QzjaDLHQyVZfP8cV9+CqVYfd9MpWm8u3vQTS2IYPngPNtk41bFbQWU1bECrrdMfh
         ffq6v/v/5wdlRCBCLg7lAy8YgtQJ+PWjVP+dykTjPpq+q12ojCHFqAEnTja5CaiYCWAo
         FKzQ==
X-Gm-Message-State: AOJu0Yx0G0RMUJlZEpLemcpYtBQne7iq0RC2nCs2Y8LF4xQ5EI67L0mb
        aaa0jhww5F89iIzDTeg5f0WaHw==
X-Google-Smtp-Source: AGHT+IEM0jhYe8OIyJVgIN1aZyptyxQiXDtplBZuTljT0XzOVBrzHoD7FYZACjKGOsHLvoVZ/wOOew==
X-Received: by 2002:a17:902:9b8e:b0:1c6:845:27c5 with SMTP id y14-20020a1709029b8e00b001c6084527c5mr13417148plp.61.1696307661424;
        Mon, 02 Oct 2023 21:34:21 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id ji17-20020a170903325100b001c444106bcasm341059plb.46.2023.10.02.21.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 21:34:20 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qnX6w-008l4e-0d;
        Tue, 03 Oct 2023 15:34:18 +1100
Date:   Tue, 3 Oct 2023 15:34:18 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 11/21] fs: xfs: Don't use low-space allocator for
 alignment > 1
Message-ID: <ZRuZymVoFI7EUjbS@dread.disaster.area>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-12-john.g.garry@oracle.com>
 <ZRtrap9v9xJrf6nq@dread.disaster.area>
 <20231003030010.GE21298@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003030010.GE21298@frogsfrogsfrogs>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Oct 02, 2023 at 08:00:10PM -0700, Darrick J. Wong wrote:
> On Tue, Oct 03, 2023 at 12:16:26PM +1100, Dave Chinner wrote:
> > On Fri, Sep 29, 2023 at 10:27:16AM +0000, John Garry wrote:
> > > The low-space allocator doesn't honour the alignment requirement, so don't
> > > attempt to even use it (when we have an alignment requirement).
> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >  fs/xfs/libxfs/xfs_bmap.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> > > index 30c931b38853..328134c22104 100644
> > > --- a/fs/xfs/libxfs/xfs_bmap.c
> > > +++ b/fs/xfs/libxfs/xfs_bmap.c
> > > @@ -3569,6 +3569,10 @@ xfs_bmap_btalloc_low_space(
> > >  {
> > >  	int			error;
> > >  
> > > +	/* The allocator doesn't honour args->alignment */
> > > +	if (args->alignment > 1)
> > > +		return 0;
> > > +
> > 
> > How does this happen?
> > 
> > The earlier failing aligned allocations will clear alignment before
> > we get here....
> 
> I was thinking the predicate should be xfs_inode_force_align(ip) to save
> me/us from thinking about all the other weird ways args->alignment could
> end up 1.
> 
> 	/* forced-alignment means we don't use low mode */
> 	if (xfs_inode_force_align(ip))
> 		return -ENOSPC;

See the email I just wrote about not needing per-inode on-disk state
or even extent size hints for doing allocation for atomic IO. Atomic
write unit alignment is a device parameter (similar to stripe unit)
that applies to context specific allocation requests - it's not an
inode property as such....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
