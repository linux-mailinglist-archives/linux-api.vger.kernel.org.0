Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF3E2BBDB0
	for <lists+linux-api@lfdr.de>; Sat, 21 Nov 2020 08:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbgKUHAu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 21 Nov 2020 02:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbgKUHAt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 21 Nov 2020 02:00:49 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C3DC061A4D
        for <linux-api@vger.kernel.org>; Fri, 20 Nov 2020 23:00:49 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id b17so12382569ljf.12
        for <linux-api@vger.kernel.org>; Fri, 20 Nov 2020 23:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zCcA4sLycmShyMxZ6i9Eumf1OUB1JNsCrcUOdwj1SQI=;
        b=dyVl3+GKSo/xVNAFCoPUWUc6gQmdnw/aoaQ4OWYQZWi2kHziBvNSeTnr32XAufXgxx
         hKm1lXxIoBOeyloaPYvydgxjC+QYQhPhdTBvC3QDAyA7AJyAjx1Sfg+qUFcGGSyONF8a
         rMKz4vmvLjBUQoyU5nljmBLmfmujXCOPYrMhv1QkKNn3puxg8Bv8DNt5W2ZOwFPaeWbF
         Wzo6H7mzy9nAyHb2lga5U1+/aFxC+fqkiabeBSqjroyj0XzDF5MUiNTLKPowTk9qU32M
         0Frm4j8FEeopwqA7QqTNyauy419MUnrYWXvN0JzetsvpCro/b6d4UfZLXFRL8XQqSWR4
         iSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zCcA4sLycmShyMxZ6i9Eumf1OUB1JNsCrcUOdwj1SQI=;
        b=QblgzjzTvhvb1IF3oND1sUTD12Ct+rTehqRzpDuRIZw/3L2iKV5/MkE3Ip8NAmMO35
         4D0H0j/mmtdLOgivFX9PQiw0GpCQqcClS5Jh1TI1SuQns3U5oLIjiwmmgjiL1RNA3Rm5
         b1vpWUEiXrNJJEl1wWV13qPaIkPOkOXM1wcb51qbEpn5nSH40UrS1PyEYyrL7agYBLYR
         U04kEmCPDxABPBtPPicojBgu0AbfSnnL77sph9j5obrR9pxv7ny85bwVEtfA6M3sKfcw
         LhEvUNlpsSX4YvmlRtrxEiaTlfMKsgdfK+/ekvlbtkRLyT6dS10wnWU1VO3k1HLFcIHG
         vIdA==
X-Gm-Message-State: AOAM533W1oJlkUaacJv/5HUdxK1c5tAynoppEla8APBcH4SqbiDFYiq8
        74s0/fqQnqAb+an+svpT0f/u0lmXuucgTZBr5TYcyg==
X-Google-Smtp-Source: ABdhPJy8wln+obg/cf+h2tvCfZva23mNjQ3IqbWTfUAeh0QB4VP+04PcFgpYrhykI0RBGORAa7WxIWYKQRHp7mANu3Y=
X-Received: by 2002:a2e:9d8d:: with SMTP id c13mr9054289ljj.160.1605942047455;
 Fri, 20 Nov 2020 23:00:47 -0800 (PST)
MIME-Version: 1.0
References: <20201112205141.775752-1-mic@digikod.net> <20201112205141.775752-8-mic@digikod.net>
In-Reply-To: <20201112205141.775752-8-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 21 Nov 2020 08:00:00 +0100
Message-ID: <CAG48ez3HA63CX852LLDFCcNyzRGwAr3x_cvA1-t8tgDxfF1dOQ@mail.gmail.com>
Subject: Re: [PATCH v24 07/12] landlock: Support filesystem access-control
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 12, 2020 at 9:52 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> Thanks to the Landlock objects and ruleset, it is possible to identify
> inodes according to a process's domain.  To enable an unprivileged
> process to express a file hierarchy, it first needs to open a directory
> (or a file) and pass this file descriptor to the kernel through
> landlock_add_rule(2).  When checking if a file access request is
> allowed, we walk from the requested dentry to the real root, following
> the different mount layers.  The access to each "tagged" inodes are
> collected according to their rule layer level, and ANDed to create
> access to the requested file hierarchy.  This makes possible to identify
> a lot of files without tagging every inodes nor modifying the
> filesystem, while still following the view and understanding the user
> has from the filesystem.
>
> Add a new ARCH_EPHEMERAL_INODES for UML because it currently does not
> keep the same struct inodes for the same inodes whereas these inodes are
> in use.
>
> This commit adds a minimal set of supported filesystem access-control
> which doesn't enable to restrict all file-related actions.  This is the
> result of multiple discussions to minimize the code of Landlock to ease
> review.  Thanks to the Landlock design, extending this access-control
> without breaking user space will not be a problem.  Moreover, seccomp
> filters can be used to restrict the use of syscall families which may
> not be currently handled by Landlock.
>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> ---
>
> Changes since v23:
> * Enforce deterministic interleaved path rules.  To have consistent
>   layered rules, granting access to a path implies that all accesses
>   tied to inodes, from the requested file to the real root, must be
>   checked.  Otherwise, stacked rules may result to overzealous
>   restrictions.  By excluding the ability to add exceptions in the same
>   layer (e.g. /a allowed, /a/b denied, and /a/b/c allowed), we get
>   deterministic interleaved path rules.  This removes an optimization

I don't understand the "deterministic interleaved path rules" part.


What if I have a policy like this?

/home/user READ
/home/user/Downloads READ+WRITE

That's a reasonable policy, right?

If I then try to open /home/user/Downloads/foo in WRITE mode, the loop
will first check against the READ+WRITE rule for /home/user, that
check will pass, and then it will check against the READ rule for /,
which will deny the access, right? That seems bad.


The v22 code ensured that for each layer, the most specific rule (the
first we encounter on the walk) always wins, right? What's the problem
with that?

>   which could be replaced by a proper cache mechanism.  This also
>   further simplifies and explain check_access_path_continue().

From the interdiff between v23 and v24 (git range-diff
99ade5d59b23~1..99ade5d59b23 faa8c09be9fd~1..faa8c09be9fd):

    @@ security/landlock/fs.c (new)
     +                  rcu_dereference(landlock_inode(inode)->object));
     +  rcu_read_unlock();
     +
    -+  /* Checks for matching layers. */
    -+  if (rule && (rule->layers | *layer_mask)) {
    -+          if ((rule->access & access_request) =3D=3D access_request) =
{
    -+                  *layer_mask &=3D ~rule->layers;
    -+                  return true;
    -+          } else {
    -+                  return false;
    -+          }
    ++  if (!rule)
    ++          /* Continues to walk if there is no rule for this inode. */
    ++          return true;
    ++  /*
    ++   * We must check all layers for each inode because we may encounter
    ++   * multiple different accesses from the same layer in a walk.  Each
    ++   * layer must at least allow the access request one time (i.e. with=
 one
    ++   * inode).  This enables to have a deterministic behavior whatever
    ++   * inode is tagged within interleaved layers.
    ++   */
    ++  if ((rule->access & access_request) =3D=3D access_request) {
    ++          /* Validates layers for which all accesses are allowed. */
    ++          *layer_mask &=3D ~rule->layers;
    ++          /* Continues to walk until all layers are validated. */
    ++          return true;
     +  }
    -+  return true;
    ++  /* Stops if a rule in the path don't allow all requested access. */
    ++  return false;
     +}
     +
     +static int check_access_path(const struct landlock_ruleset *const dom=
ain,
    @@ security/landlock/fs.c (new)
     +                          &layer_mask)) {
     +          struct dentry *parent_dentry;
     +
    -+          /* Stops when a rule from each layer granted access. */
    -+          if (layer_mask =3D=3D 0) {
    -+                  allowed =3D true;
    -+                  break;
    -+          }
    -+

This change also made it so that disconnected paths aren't accessible
unless they're internal, right? While previously, the access could be
permitted if the walk stops before reaching the disconnected point? I
guess that's fine, but it should probably be documented.

     +jump_up:
     +          /*
     +           * Does not work with orphaned/private mounts like overlayf=
s
    @@ security/landlock/fs.c (new)
     +                          goto jump_up;
     +                  } else {
     +                          /*
    -+                           * Stops at the real root.  Denies access
    -+                           * because not all layers have granted acce=
ss.
    ++                           * Stops at the real root.  Denies access i=
f
    ++                           * not all layers granted access.
     +                           */
    -+                          allowed =3D false;
    ++                          allowed =3D (layer_mask =3D=3D 0);
     +                          break;
     +                  }
     +          }
