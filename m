Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFA67CE6B7
	for <lists+linux-api@lfdr.de>; Wed, 18 Oct 2023 20:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjJRSft (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Oct 2023 14:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjJRSfs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Oct 2023 14:35:48 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D53DF7;
        Wed, 18 Oct 2023 11:35:42 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-66d0760cd20so60153006d6.0;
        Wed, 18 Oct 2023 11:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697654141; x=1698258941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tF4IybATL1pJ3n0HP7pLFs/t3oo7yD7OlL4dKsrLvS0=;
        b=YZ5vhVnj39UXNq4JtSMsammPecU8nd6nkdmMY90yCl72CweShxe+6KfIQRj3p/kqRu
         5uj6jAbwxbdKg/FFtJMSR2w+O+R5IHv4x15gFHueaUCW7xVe1xGhOMIQVoEexKv3xNnK
         NlKmyQyHX7aFe7YJPDSsvUyYH7+UIAaqYZjtJkPww0eC/UCTpt2X4ArFMN/WpFTbq8Pr
         CgpZSFRGWMrk2OfH7UWoMvBFBS+acjyVVCs+6vGQdZMQQVZUsRwuqoq5VeCnM3EOCqdh
         TD8l/+0oKwLyzA0/cKddHZ0EUna5RFm4N0Xgxna6fSkiKd1vpiGKzlEIpwJuZe8vpzTj
         EGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697654141; x=1698258941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tF4IybATL1pJ3n0HP7pLFs/t3oo7yD7OlL4dKsrLvS0=;
        b=uCq3wLBa0yL20KBQADXkovWFb3Q8PuD/l1qoO+oh9EVMTWLFRnk3ohd4w/lUQYRmr9
         I3BBiL+ZHzQDR+Eypf72Nu4HFGJk3iFd2NCJh1h1csYngAKqNjivQJeXNV0xqtyZUyfD
         pXH/DTxLjmBIte1PBHGQzJoZxSUd0lhTUDWrnIbDmAFj3Q0hyCD07bK+wl6umKsY5DEp
         DWxMc7aUYUF2VtsuCOKYPw0tm6KezEfjiXxs6VtVFJszx0BPFa4blKclHJcGtv2Wa8Gb
         Z+xkiHfmY9kC6h7s5s4lK/zcvIWWj07g4NMmUVu4V1b5QhgtA1wuJkko8NzCSthQUGYe
         uTSw==
X-Gm-Message-State: AOJu0YxuItL4z0YsgZNQowVociUfgr59ICGMT10Kj4gg0Zf2G/txz1oL
        E4zQh03GBDAShQBddKwCovP95R63vSMF03uad/c=
X-Google-Smtp-Source: AGHT+IF8cO0xbv1VXNQ95Ky7TEdM17RjGVcnIxx+ZCkMYz7kNqlshTh0HVSxAx1z5GuO6ldzdtMzKTVdnfkeJFQ5kTI=
X-Received: by 2002:a05:6214:f01:b0:66d:5a3a:c5e6 with SMTP id
 gw1-20020a0562140f0100b0066d5a3ac5e6mr320519qvb.18.1697654141422; Wed, 18 Oct
 2023 11:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230411124037.1629654-1-amir73il@gmail.com> <20230412184359.grx7qyujnb63h4oy@quack3>
 <CAOQ4uxj_OQt+yLVnBH-Cg4mKe4_19L42bcsQx2BSOxR7E46SDQ@mail.gmail.com>
 <20230417162721.ouzs33oh6mb7vtft@quack3> <CAOQ4uxjfP+TrDded+Zps6k6GQM+UsEuW0R2PT_fMEH8ouY_aUg@mail.gmail.com>
 <20230920110429.f4wkfuls73pd55pv@quack3> <CAOQ4uxisRMZh_g-M06ROno9g-E+u2ME0109FAVJLiV4V=mwKDw@mail.gmail.com>
 <20230920134829.n74smxum27herhl6@quack3> <CAOQ4uxj-5n3ja+22Qv4H27wEGn=eAdE1JNRBSxS3TgdEr7b75A@mail.gmail.com>
 <20230920163634.5agdx523uv7m2qtf@quack3>
In-Reply-To: <20230920163634.5agdx523uv7m2qtf@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 18 Oct 2023 21:35:30 +0300
Message-ID: <CAOQ4uxjpMqzzgc--302n4Vc_PLO-RPppk65pSo6B_V-3XiK_Lw@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: Enable FAN_REPORT_FID on more filesystem types
To:     Jan Kara <jack@suse.cz>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 20, 2023 at 7:36=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 20-09-23 18:12:00, Amir Goldstein wrote:
> > On Wed, Sep 20, 2023 at 4:48=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > > If users had a flag to statfs() to request the "btrfs root volume f=
sid",
> > > > then fanotify could also report the root fsid and everyone will be =
happy
> > > > because the btrfs file handle already contains the subvolume root
> > > > object id (FILEID_BTRFS_WITH_PARENT_ROOT), but that is not
> > > > what users get for statfs() and that is not what fanotify documenta=
tion
> > > > says about how to query fsid.
> > > >
> > > > We could report the subvolume fsid for marked inode/mount
> > > > that is not a problem - we just cache the subvol fsid in inode/moun=
t
> > > > connector, but that fsid will be inconsistent with the fsid in the =
sb
> > > > connector, so the same object (in subvolume) can get events
> > > > with different fsid (e.g. if one event is in mask of sb and another
> > > > event is in mask of inode).
> > >
> > > Yes. I'm sorry I didn't describe all the details. My idea was to repo=
rt
> > > even on a dentry with the fsid statfs(2) would return on it. We don't=
 want
> > > to call dentry_statfs() on each event (it's costly and we don't alway=
s have
> > > the dentry available) but we can have a special callback into the
> > > filesystem to get us just the fsid (which is very cheap) and call *th=
at* on
> > > the inode on which the event happens to get fsid for the event. So ye=
s, the
> > > sb mark would be returning events with different fsids for btrfs. Or =
we
> > > could compare the obtained fsid with the one in the root volume and i=
gnore
> > > the event if they mismatch (that would be more like the different sub=
volume
> > > =3D> different filesystem point of view and would require some more w=
ork on
> > > fanotify side to remember fsid in the sb mark and not in the sb conne=
ctor).
> > >
> >
> > It sounds like a big project.
>
> Actually it should be pretty simple as I imagine it. Maybe I can quickly
> hack a POC.
>

I think I get what you mean.
Pushed POC (only compile tested so far) to branch inode_fsid on my github [=
1]
and posted the patches for seamless support for non-decodable fid.

Let me know if that is what you meant.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/inode_fsid
