Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA664145E05
	for <lists+linux-api@lfdr.de>; Wed, 22 Jan 2020 22:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgAVV3t (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 22 Jan 2020 16:29:49 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44285 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729456AbgAVV3l (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 22 Jan 2020 16:29:41 -0500
Received: by mail-lj1-f196.google.com with SMTP id q8so681680ljj.11
        for <linux-api@vger.kernel.org>; Wed, 22 Jan 2020 13:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bxPhh7N7fIA127zr04oMv8OimndCsehwtjANlH0ufAg=;
        b=VG+pSGaQEHZ01TdE6+inaGCl7YIbKV9BQclbGxGKMBuWJI1/IniG8OJQ/PmZgSAqRR
         8E8az/WCM9eetPppdm2WfrskxLGjsmff77/uc0ifBf4LCWMBMWgyB5A8y/pMa9fCtBkS
         iPAVZl36IuQJFXEK7CcgeOT5L0sv/ij6f/gHyxRD+QgVwSaFAk8HURScNnari2n6kEcI
         IVUqWDdrv97oGI7vkGBLqlZNOxueQ8DNFJaxgE8pWiVnqjpv93ZTkEm3y+GrS5vo9eh6
         mqxkeG5NAUIG65H1IVdlfGB6ZlFASVR9vEtQwZl+aYxBvcEIT5ACrAVI9oB6zVzvUnZp
         PAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bxPhh7N7fIA127zr04oMv8OimndCsehwtjANlH0ufAg=;
        b=FsMmx9TMPPBZcPDj7RAmY3/Ld57cIQOqikK230CVPNkraPTdzDeWUorVeKVZtGMuGL
         zdxane9XYZ1lqnV12WrdSZMpo7yqNQfhAzvMJMh+2AGXGtKKlRjm682VugfpSGgJS+ui
         oBO+s88ZzOv/A+yj3f6a9agJI/oV/QajS794/hDJpsTG+AcbZgW8WpK5gb7BT52QGnlK
         H7xOLHQZhPYtJpn6UN32ohwlWR7TnsyiYHoI31PWGEWEbWrwAbPeKmAl709fU6rdi6zM
         cQ8GM9feQpWVacRKvoE1pC0g3CENYHf41upijGVSF37M1D5uIAUpmXkqAPdbCGahl+eY
         bEVA==
X-Gm-Message-State: APjAAAWsvKtDtaddGrcxNBI5T49NPTFM3olaRAqQaQkGZUQzOfh88PKG
        st90MyB3nakXzKt6q9U9K3eM7nZyuiTLOjJzvqGZ
X-Google-Smtp-Source: APXvYqzeo+JIXOnTNsp8hlNCS0EhcIav6k16IWLVBCjbo48MM+ye9PmS2K9sFncvQx6VkvN1QXW6bcGPUW1n+S8axUk=
X-Received: by 2002:a2e:870b:: with SMTP id m11mr20503341lji.93.1579728580019;
 Wed, 22 Jan 2020 13:29:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577736799.git.rgb@redhat.com> <229a7be1f1136906a360a46e2cf8cdcd4c7c4b1b.1577736799.git.rgb@redhat.com>
In-Reply-To: <229a7be1f1136906a360a46e2cf8cdcd4c7c4b1b.1577736799.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 22 Jan 2020 16:29:29 -0500
Message-ID: <CAHC9VhS2h8LfYCZOkjmvSkJ5rXXJTEkRwrBMHZW=TYkpaKVUyA@mail.gmail.com>
Subject: Re: [PATCH ghak90 V8 15/16] audit: check contid count per netns and
 add config param limit
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Dec 31, 2019 at 2:51 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Clamp the number of audit container identifiers associated with a
> network namespace to limit the netlink and disk bandwidth used and to
> prevent losing information from record text size overflow in the contid
> field.
>
> Add a configuration parameter AUDIT_STATUS_CONTID_NETNS_LIMIT (0x100)
> to set the audit container identifier netns limit.  This is used to
> prevent overflow of the contid field in CONTAINER_OP and CONTAINER_ID
> messages, losing information, and to limit bandwidth used by these
> messages.
>
> This value must be balanced with the audit container identifier nesting
> depth limit to multiply out to no more than 400.  This is determined by
> the total audit message length less message overhead divided by the
> length of the text representation of an audit container identifier.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/audit.h      | 16 +++++++----
>  include/linux/nsproxy.h    |  2 +-
>  include/uapi/linux/audit.h |  2 ++
>  kernel/audit.c             | 68 ++++++++++++++++++++++++++++++++++++++--------
>  kernel/audit.h             |  7 +++++
>  kernel/fork.c              | 10 +++++--
>  kernel/nsproxy.c           | 27 +++++++++++++++---
>  7 files changed, 107 insertions(+), 25 deletions(-)

Similar to my comments in patch 14, let's defer this to a later time
if we need to do this at all.

--
paul moore
www.paul-moore.com
