Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B34B82D71A
	for <lists+linux-api@lfdr.de>; Wed, 29 May 2019 09:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfE2Hzu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 May 2019 03:55:50 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39382 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfE2Hzu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 May 2019 03:55:50 -0400
Received: by mail-it1-f195.google.com with SMTP id 9so2055078itf.4
        for <linux-api@vger.kernel.org>; Wed, 29 May 2019 00:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=op4791qBHMjDCQdV9txK9mbzIX+WhgzeovFSwUXqaFQ=;
        b=YbZYex+MkYR9h819JTNbMfn9OoTfQc0WfMl0pIniSUlyhGceEB4vQ8StrtFyuiAy4w
         V/rdXa8qsaNoWL4xwbh2GBDzhIEKxgBZMsNRyZjGgmPoBJPWEYu2f0YjJis9SSPtC26W
         UD998MyvHLyBc5OYtLE92jxNIzzt5APPCEtC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=op4791qBHMjDCQdV9txK9mbzIX+WhgzeovFSwUXqaFQ=;
        b=lq23Nx/0X3oIH0e8KSZn5N0/C75GecDIPXe+IL3X5pdifKf3MWFwgTcoGHrCbui1tW
         gaL7qQN6Ay4dVanIhn3SFx9ffuuPJdIrVMrFQHPi4bg/lPiS0IXeLbv5ApkhOJ+cbJua
         Mjk7y1dvL6zbhHYI/CrgBaMBoowGod0TZHnVWS4sqy+NIxGP+G7buTSA2ZYD6/AEVdp5
         04pt3xdMslu+HtRCUbfr3vY/Y9UYmmcGMGi+Maw+E+qhkZFzQl+s7KDHMy/F0T9U7tRT
         SiF9r/kFi8VMgjHKOQ/dfXHN5Y/ObYwQuVeTubdnRNe5EZFsX0dYJADBLGcR2CdJqPUa
         sClA==
X-Gm-Message-State: APjAAAVzlWkQyaA7aS+Tp3gqVtMSHkbJlHCP7PmaKv8NsB+P29RmjPGr
        uvVuMphqSjf2baNRFTUhiq3rbiQKA95dMqKD1eEvRw==
X-Google-Smtp-Source: APXvYqy/whcusTY4hHDoC4X+OnP9aaNKf6KjmFpD6uW6iIEpnRrUQmEJ77wekoH11aNFI99khObtXhKqxO04kVXVSD0=
X-Received: by 2002:a24:4dd4:: with SMTP id l203mr6105131itb.118.1559116549227;
 Wed, 29 May 2019 00:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <155905621951.1304.5956310120238620025.stgit@warthog.procyon.org.uk>
 <155905622921.1304.8775688192987027250.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905622921.1304.8775688192987027250.stgit@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 29 May 2019 09:55:38 +0200
Message-ID: <CAJfpeguPTQ00zVjpwVQ4R8mEqE3aijCzNMAz6Wvr56xE-jfJag@mail.gmail.com>
Subject: Re: [PATCH 1/7] General notification queue with user mmap()'able ring
 buffer [ver #13]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 28, 2019 at 5:10 PM David Howells <dhowells@redhat.com> wrote:
>
> Implement a misc device that implements a general notification queue as a
> ring buffer that can be mmap()'d from userspace.
>
> The way this is done is:
>
>  (1) An application opens the device and indicates the size of the ring
>      buffer that it wants to reserve in pages (this can only be set once):
>
>         fd = open("/dev/watch_queue", O_RDWR);
>         ioctl(fd, IOC_WATCH_QUEUE_NR_PAGES, nr_of_pages);
>
>  (2) The application should then map the pages that the device has
>      reserved.  Each instance of the device created by open() allocates
>      separate pages so that maps of different fds don't interfere with one
>      another.  Multiple mmap() calls on the same fd, however, will all work
>      together.
>
>         page_size = sysconf(_SC_PAGESIZE);
>         mapping_size = nr_of_pages * page_size;
>         char *buf = mmap(NULL, mapping_size, PROT_READ|PROT_WRITE,
>                          MAP_SHARED, fd, 0);

Would it make sense to use relayfs for the implementation of the
mapped ring buffer?

Thanks,
Miklos
