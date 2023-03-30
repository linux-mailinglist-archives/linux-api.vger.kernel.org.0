Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162576D0EB6
	for <lists+linux-api@lfdr.de>; Thu, 30 Mar 2023 21:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjC3TZd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Mar 2023 15:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjC3TZT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 Mar 2023 15:25:19 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029C01025D;
        Thu, 30 Mar 2023 12:24:41 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso14044789wmb.0;
        Thu, 30 Mar 2023 12:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680204279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/1WlejRA6jsZvIXqlLPw6YewfrLV5VAAUmFxpGwdQNk=;
        b=LJbVReQD8HGM3QrEFQQ5VCz/AkFqTXkKWgL8agFSV/iJZgYBGMH1FKuksBvi39PXVB
         mh9i9S4bpgjKbQvTVpI2WDYr/0RFCe0QoLwCrPJ7Bba8EoPceQjt0vD7AbTH8jN1PWPJ
         iAzorEsCIGhMxJVV2zKGtpevRbkQAhKcIc9Ti6lSDPy0LDgqBlWmyMpBwmUcq1ggVA9i
         +5qAKDnpCCR71S06LNiMVfjWJcT+6WiVkY2SJYNwQ4hlEfYLw+VdqwLtxJuYrohRPaCq
         k2Z0O79g/diES7IbSbs9Wjl5dKqXG3SRl20NZQsEUkJQxrMJQMw3bdcYO+qU3YkNpfdN
         2bEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680204279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1WlejRA6jsZvIXqlLPw6YewfrLV5VAAUmFxpGwdQNk=;
        b=M/5Nlke/PBNNUqoy8TByBmOAkuPRWK8m/6FwWzVEehQHjt5f0KIAtyT3f4zxEDyLUn
         yfkgvTEdJoz5zD97vngZ0YuJ3QaSEi/WKGBZvzc1LENvXut7Xv9CRBar9IBjaFYiSgBY
         RBuPWWY5WhrQ25nSumCBWF4kcGYfOoqFBega5T+HLOtupLx3k3AaQAsSVE0eNla9MlWb
         JSRCmQ4/qTl86Ldm2f1yery958YdcJNRFIgBgeTI2oew+3tcM4IZybFaO8fUvuo0LDEF
         BwPTqh9G+K+FrPu3MhibP4rWX1uKUVMWCk153MVcOCEz2brL+UjjAN/Mf8n8e3o+tFXK
         9A/w==
X-Gm-Message-State: AAQBX9eU+mC5ivB0r5fwP3zAsc99N5uYFilyEk7tEtmi57ZYg9A7TidP
        WSNT1rAaDxOlg/r1G+qsoqDIypNUG+E=
X-Google-Smtp-Source: AKy350ag6yicidw5Yqy4p4poF1fhXqv2CT8CIaqa/0L+jQkTuHCIVxVRgX+pNkS6Ca+T0miznHIc6A==
X-Received: by 2002:a7b:c7cb:0:b0:3ed:5d41:f998 with SMTP id z11-20020a7bc7cb000000b003ed5d41f998mr5624923wmk.15.1680204279109;
        Thu, 30 Mar 2023 12:24:39 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id i22-20020a05600c355600b003ede6540190sm7495043wmq.0.2023.03.30.12.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 12:24:38 -0700 (PDT)
Date:   Thu, 30 Mar 2023 20:24:37 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, David Herrmann <dh.herrmann@gmail.com>,
        yshuiv7@gmail.com, bugzilla-daemon@kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [Bug 217238] New: Creating shared read-only map is denied after
 add write seal to a memfd
Message-ID: <a586f817-dbe4-4a44-b516-6086d9a89962@lucifer.local>
References: <bug-217238-27@https.bugzilla.kernel.org/>
 <20230324133646.16101dfa666f253c4715d965@linux-foundation.org>
 <45e081de-47a9-49e1-8420-51979dad40f5@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45e081de-47a9-49e1-8420-51979dad40f5@lucifer.local>
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Mar 25, 2023 at 02:51:05PM +0000, Lorenzo Stoakes wrote:
> On Fri, Mar 24, 2023 at 01:36:46PM -0700, Andrew Morton wrote:
> > (switched to email.  Please respond via emailed reply-to-all, not via the
> > bugzilla web interface).
> >
> > On Fri, 24 Mar 2023 03:34:23 +0000 bugzilla-daemon@kernel.org wrote:
> >
> > > https://bugzilla.kernel.org/show_bug.cgi?id=217238
> > >
> > >             Bug ID: 217238
> > >            Summary: Creating shared read-only map is denied after add
> > >                     write seal to a memfd
> > >            Product: Memory Management
> > >            Version: 2.5
> > >     Kernel Version: 6.2.8
> > >           Hardware: All
> > >                 OS: Linux
> > >               Tree: Mainline
> > >             Status: NEW
> > >           Severity: normal
> > >           Priority: P1
> > >          Component: Other
> > >           Assignee: akpm@linux-foundation.org
> > >           Reporter: yshuiv7@gmail.com
> > >         Regression: No
> > >
> > > Test case:
> > >
> > >     int main() {
> > >       int fd = memfd_create("test", MFD_ALLOW_SEALING);
> > >       write(fd, "test", 4);
> > >       fcntl(fd, F_ADD_SEALS, F_SEAL_WRITE);
> > >
> > >       void *ret = mmap(NULL, 4, PROT_READ, MAP_SHARED, fd, 0);
> > >     }
> > >
> > > This fails with EPERM. This is in contradiction with what's described in the
> > > documentation of F_SEAL_WRITE.
> > >
> > > --
> > > You may reply to this email to add a comment.
> > >
> > > You are receiving this mail because:
> > > You are the assignee for the bug.
> >
>
> This issue seems to be the result of the use of the memfd's shmem region's
> page cache object (struct address_space)'s i_mmap_writable field to denote
> whether it is write-sealed.
>
> The kernel assumes that a VM_SHARED mapping might become writable at any
> time via mprotect(), therefore treats VM_SHARED mappings as if they were
> writable as far as i_mmap_writable is concerned (this field's primary use
> is to determine whether, for architectures that require it, flushing must
> occur if this is set to avoid aliasing, see filemap_read() for example).
>
> In theory we could convert all such checks to VM_SHARED | VM_WRITE
> (importantly including on fork) and then update mprotect() to check
> mapping_map_writable() if a user tries to make unwritable memory
> writable.
>
> I suspect however there are reasons relating to locking that make it
> unreasonable to try to do this, but I may be mistaken (others might have
> some insight on this). I also see some complexity around this in the
> security checks on marking shared writable mappings executable (e.g. in
> mmap_violation_check()).
>
> In any case, it doesn't really make much sense to have a write-sealed
> shared mapping, since you're essentially saying 'nothing _at all_ can write
> to this' so it may as well be private. The semantics are unfortunate here,
> the memory will still be shared read-only by MAP_PRIVATE mappings.
>
> A better choice here might be F_SEAL_FUTURE_WRITE (available from kernel
> >=5.1) which does permit shared read-only mappings as this is explicitly
> checked for in seal_check_future_write() invoked from shmem_mmap().
>
> Regardless, I think the conclusion is that this is not a bug, but rather
> that the documentation needs to be updated.
>

Adding docs people to cc list (sorry didn't think to do this in first
reply).
