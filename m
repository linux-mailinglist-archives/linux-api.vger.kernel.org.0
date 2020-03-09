Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0B1D17EC49
	for <lists+linux-api@lfdr.de>; Mon,  9 Mar 2020 23:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgCIWtj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Mar 2020 18:49:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27261 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727320AbgCIWtj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 9 Mar 2020 18:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583794177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HV3qgkcKTLqlj5wcbDRS2AXp9vzUwXBC/9+EqfzmMvM=;
        b=flB/qYV3oZtemL7FunkCvY3h1OPfoFmETpZisaE7fLoKqoVF1mnp1LeoojWJ/hqDnSIfjK
        aOYVM6SjPk5DuXhcSCmVM1u++HokVeiVTwQI64ODG9TWV5gXHJxcWeUCI0wf4En3tIosMc
        8RvFxavJGloK6l6kxGyjgFE+bHtXm3o=
Received: from mail-yw1-f71.google.com (mail-yw1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-xs6mxgTaNvGWMGMp3juGSQ-1; Mon, 09 Mar 2020 18:49:34 -0400
X-MC-Unique: xs6mxgTaNvGWMGMp3juGSQ-1
Received: by mail-yw1-f71.google.com with SMTP id p132so3246061ywb.2
        for <linux-api@vger.kernel.org>; Mon, 09 Mar 2020 15:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=HV3qgkcKTLqlj5wcbDRS2AXp9vzUwXBC/9+EqfzmMvM=;
        b=e9/SqmZpc+6qL3I0vW4GP7n67pcKadp3wVxmlmBJ2fIc6Nfyiu7fvO/xc93x90gJrG
         /03E71ZVsCv1p3C+vqGln88JRL+mI9dht3K6+dKS83SV/xgwd5h2A4S5CyZ6zmsaJ0on
         F7GyOvxyrlbZumPnpVOiWj+9zKflVrB0jvWUrqZdYIO0EJ2XDFF6wnYo2LdgECd2+2az
         7fIP+b2AphLEPxDfb17Pc9TWetnvLylLYzepSUCzSWnWcElYFnx13s12+EMa7s5Q2s1s
         wTf1nM0FYNrqrTVtL1ULwA/4OJx+0oM+BQxqiCzn1z755E934gITM0cspMOcL0sUJlet
         PWqA==
X-Gm-Message-State: ANhLgQ26FAE6eSAKPkiRjNbAi9qqqHI7qlzLV3TkBD4sWDd2xlsIb6Y4
        ug3EZsqLtdwt/MKZHEZLuagH/lsvS7yNk/G0qZ39kCMf8qAX6UzVrgsBeqrWYtSJuunpJFkW+c+
        PvJD0PhAQKlIGnoeomG3P
X-Received: by 2002:a25:2146:: with SMTP id h67mr19645205ybh.92.1583794173508;
        Mon, 09 Mar 2020 15:49:33 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvt6Q0tj/V6bzMSoorE++/YZCJuiryDKikREWseTxP4/vg08CzbzDn75K5ktPnB52gDWscllg==
X-Received: by 2002:a25:2146:: with SMTP id h67mr19645165ybh.92.1583794173070;
        Mon, 09 Mar 2020 15:49:33 -0700 (PDT)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id w17sm3584845ywa.8.2020.03.09.15.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 15:49:32 -0700 (PDT)
Message-ID: <32c384ac3adf0cf924d3071a13af7edffe53cc2b.camel@redhat.com>
Subject: Re: [PATCH 00/14] VFS: Filesystem information [ver #18]
From:   Jeff Layton <jlayton@redhat.com>
To:     Andres Freund <andres@anarazel.de>
Cc:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, Theodore Ts'o <tytso@mit.edu>,
        Stefan Metzmacher <metze@samba.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-api@vger.kernel.org,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, darrick.wong@oracle.com, kzak@redhat.com,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 09 Mar 2020 18:49:31 -0400
In-Reply-To: <20200309192240.nqf5bxylptw7mdm3@alap3.anarazel.de>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
         <2d31e2658e5f6651dc7d9908c4c12b6ba461fc88.camel@redhat.com>
         <20200309192240.nqf5bxylptw7mdm3@alap3.anarazel.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 2020-03-09 at 12:22 -0700, Andres Freund wrote:
> Hi,
> 
> On 2020-03-09 13:50:59 -0400, Jeff Layton wrote:
> > The PostgreSQL devs asked a while back for some way to tell whether
> > there have been any writeback errors on a superblock w/o having to do
> > any sort of flush -- just "have there been any so far".
> 
> Indeed.
> 
> 
> > I sent a patch a few weeks ago to make syncfs() return errors when there
> > have been writeback errors on the superblock. It's not merged yet, but
> > once we have something like that in place, we could expose info from the
> > errseq_t to userland using this interface.
> 
> I'm still a bit worried about the details of errseq_t being exposed to
> userland. Partially because it seems to restrict further evolution of
> errseq_t, and partially because it will likely up with userland trying
> to understand it (it's e.g. just too attractive to report a count of
> errors etc).

Trying to interpret the counter field won't really tell you anything.
The counter is not incremented unless someone has queried the value
since it was last checked. A single increment could represent a single
writeback error or 10000 identical ones.

There _is_ a flag that tells you whether someone has queried it, but
that gets masked off before copying the cookie to userland.

> Is there a reason to not instead report a 64bit counter instead of the
> cookie? In contrast to the struct file case we'd only have the space
> overhead once per superblock, rather than once per #files * #fd. And it
> seems that the maintenance of that counter could be done without
> widespread changes, e.g. instead/in addition to your change:
> 

What problem would moving to a 64-bit counter solve? I get the concern
about people trying to get a counter out of the cookie field, but giving
people an explicit 64-bit counter seems even more open to
misinterpretation.

All that said, is an opaque cookie still something you'd find useful?

> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index ccb14b6a16b5..897439475315 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -51,7 +51,10 @@ static inline void mapping_set_error(struct address_space *mapping, int error)
> >  		return;
> > 
> >  	/* Record in wb_err for checkers using errseq_t based tracking */
> > -	filemap_set_wb_err(mapping, error);
> > +	__filemap_set_wb_err(mapping, error);
> > +
> > +	/* Record it in superblock */
> > +	errseq_set(&mapping->host->i_sb->s_wb_err, error);
> > 
> >  	/* Record it in flags for now, for legacy callers */
> >  	if (error == -ENOSPC)
> 
> Btw, seems like mapping_set_error() should have a non-inline cold path?

Good point. I'll do that in the next iteration.

-- 
Jeff Layton <jlayton@redhat.com>

