Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A8A23B7CB
	for <lists+linux-api@lfdr.de>; Tue,  4 Aug 2020 11:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgHDJec (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 4 Aug 2020 05:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgHDJe3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 4 Aug 2020 05:34:29 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D3AC061757
        for <linux-api@vger.kernel.org>; Tue,  4 Aug 2020 02:34:28 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a14so12373867edx.7
        for <linux-api@vger.kernel.org>; Tue, 04 Aug 2020 02:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pv5BPk76i/MoWGs1gw+KWKrHA/vLK3W5JwzOEjOtqbI=;
        b=XO91VMIYWmJJyaLCqDwDI7R+/IhY8Otht/jNSco5h8lhYIS7roedId1R24+PWBV16J
         LGJrXnUSRgNnkCXYNmrxfDAd/fQa45PtQvzrfacRxUq3Htw7n9EcjRgyEZy0FGDPEzsx
         +Kf4QL8FkwyirK30cJnrDCj4Ay+ihET2LbOtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pv5BPk76i/MoWGs1gw+KWKrHA/vLK3W5JwzOEjOtqbI=;
        b=mbChEENSZArHw+/nwmH/7r7DCwWngRmcreBPNs+EroI2cXr4S2dhMulpPwMI8XZtDO
         /b7nsuUkF1kP4etogDkW/D3uUgedRyuT7GsxYgbdE2OsUYQBgTIrAJJfEJqkMUkuZXEG
         dulnRPBQLCu3aLMVk/0lpoE4isOcR9AFAf5oTekTkP4TuHK9NdcnCan4dccYyGiwrKuD
         fXMFRO9SE3A/BC/ZbcdQq89itZvs1V0d4VahSw9a61zv+VHhO2KOYtJbPsO+O9spoLhg
         K2nGTIegnX3RBE0aMJY1Z/IkpzJOE6zYCpDLN0WYLxuY39Kk4PV5E/eI1GVwByADxPzE
         Zm0Q==
X-Gm-Message-State: AOAM531HVA1LC8CflPMKmDDTGCgx7d3iDQUB3YzpYCoDZFTZnPDSMdZX
        cSeypRDTPy07jmK81OmQp7BpATXuiX+4BpdDC6gKDg==
X-Google-Smtp-Source: ABdhPJyCVcW919I6oNh7+VZo4I3h9xZy6Vr4Yw7zYMnMeDWnx5DDKuBcJyX6d89ZTqqueg33E4gXqgxVmtE7jo4mugc=
X-Received: by 2002:aa7:c915:: with SMTP id b21mr20325848edt.17.1596533666430;
 Tue, 04 Aug 2020 02:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
 <159646179405.1784947.10794350637774567265.stgit@warthog.procyon.org.uk>
In-Reply-To: <159646179405.1784947.10794350637774567265.stgit@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 4 Aug 2020 11:34:15 +0200
Message-ID: <CAJfpegvM4K1PhTkDivtzWsE2g8rBUMmzniaW8Op0XY5codvu1w@mail.gmail.com>
Subject: Re: [PATCH 01/18] fsinfo: Introduce a non-repeating system-unique
 superblock ID [ver #21]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Aug 3, 2020 at 3:37 PM David Howells <dhowells@redhat.com> wrote:
>
> Introduce an (effectively) non-repeating system-unique superblock ID that
> can be used to determine that two objects are in the same superblock
> without needing to worry about the ID changing in the meantime (as is
> possible with device IDs).
>
> The counter could also be used to tag other features, such as mount
> objects.
>
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
