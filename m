Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC0A5933DA
	for <lists+linux-api@lfdr.de>; Mon, 15 Aug 2022 19:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiHORJy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Aug 2022 13:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiHORJx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Aug 2022 13:09:53 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DFD27CCC
        for <linux-api@vger.kernel.org>; Mon, 15 Aug 2022 10:09:53 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id w197so9212028oie.5
        for <linux-api@vger.kernel.org>; Mon, 15 Aug 2022 10:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=iBe+k353gk5LIG8240LyHPzNr+hWnG7V+MJ23eeCXtY=;
        b=NWeuUYPyxQFIllRC0bXgPmr7BxnpD6MObo6CFYYjuJ6GPdHL3cDsz7Jt858NUV0ITT
         +cTSHc4ZjZz4Jc1xhkWcaA/ea1YSC2SA2a7/ULwK6YxHChx2SD7DMEn4FN/HzGCZP8Kd
         xPiowIKYBDOXd+jSIFou6wk91B1u7fYSFpgKOouAib50cXmMPf2thIKuJa4yiiJmdK/Z
         X/dCHH1BZpd4eNH87n0LI+bZSZU5duasu3tU6ZgcTA+oeoo5lJC/8Cgf3sEmXAq4iiVd
         fQQIZMYgmyuHsAu3izhUGBFLeSdElkYTPyLKJY9EPt4/nCAvcLBUfnlYAd3oJauu+D4M
         Y3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=iBe+k353gk5LIG8240LyHPzNr+hWnG7V+MJ23eeCXtY=;
        b=vBFcZU+Pk2iysuWjhfblYOum/YwKQOvXU6RQo+xacx8lvcVqP/31ENaJF9g4V2xn/m
         h/gjzcjsE0+dJzb36macXjRLq6nw39kCk0WniOLlv+ZsOrBB+0MpLZ/WUh42F6/0S0QJ
         o3T4TQIH4FwK6PK9zWFzMe3ltmfgJig+9nJU93ahPRnVvTvd4vFhZWdTowXyRoe19eBZ
         JLnPBX77ge2MAzgQ3QObAgwGB3p4rAdDxdoalkjXejWrJRizqbKjYzdLUdlZE7Fmp/V2
         ipY1U/qP/IjUYjnAZ4YIrE9LMz6xhSQHBTyn/Qs59JNBnot5Nrn31ZUlzWjMiRSM4XJ0
         nFiw==
X-Gm-Message-State: ACgBeo2nb7TXHN2v1l0ZG+CcTpLv9JCigRD0LyRMEB36yLihb5s6UR2O
        gRHJKp/eet6nKxtdP4DqErjsadkEj0ExBor72Sw9DA==
X-Google-Smtp-Source: AA6agR4tpOKT59ihpMDuUVgMNiVWeU/KCGuwR+MMAA5eF9vug2/0rtEQ2B8Uz0zWeu6E0XYYu7mDmxNhNX4JygTVYas=
X-Received: by 2002:a05:6808:10ca:b0:343:2fbe:8fa2 with SMTP id
 s10-20020a05680810ca00b003432fbe8fa2mr10465862ois.220.1660583392124; Mon, 15
 Aug 2022 10:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220812012843.3948330-4-zokeefe@google.com> <202208151331.uxreCJWj-lkp@intel.com>
In-Reply-To: <202208151331.uxreCJWj-lkp@intel.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Mon, 15 Aug 2022 10:09:16 -0700
Message-ID: <CAAa6QmTMT4jWPE_zPoxuNyWPSs=W8i2Mq8kW2NdDcFgQiNzKPg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable 3/9] mm/madvise: add file and shmem support to MADV_COLLAPSE
To:     kernel test robot <lkp@intel.com>
Cc:     linux-mm@kvack.org, kbuild-all@lists.01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        SeongJae Park <sj@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Kennelly <ckennelly@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Patrick Xia <patrickx@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Aug 14, 2022 at 10:41 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Zach,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on akpm-mm/mm-everything]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Zach-O-Keefe/mm-add-file-shmem-support-to-MADV_COLLAPSE/20220812-093122
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220815/202208151331.uxreCJWj-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/dff08746d6f7b9387b94360b66bd9db644542991
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Zach-O-Keefe/mm-add-file-shmem-support-to-MADV_COLLAPSE/20220812-093122
>         git checkout dff08746d6f7b9387b94360b66bd9db644542991
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    mm/khugepaged.c: In function 'set_huge_pmd':
> >> mm/khugepaged.c:1403:13: error: assignment of read-only variable 'vmf'
>     1403 |         vmf = (struct vm_fault) {
>          |             ^
>
>
> vim +/vmf +1403 mm/khugepaged.c
>
>   1393
>   1394  /* hpage must be locked, and mmap_lock must be held in write */
>   1395  static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
>   1396                          pmd_t *pmdp, struct page *hpage)
>   1397  {
>   1398          struct vm_fault vmf;
>   1399
>   1400          VM_BUG_ON(!PageTransHuge(hpage));
>   1401          mmap_assert_write_locked(vma->vm_mm);
>   1402
> > 1403          vmf = (struct vm_fault) {
>   1404                  .vma = vma,
>   1405                  .address = addr,
>   1406                  .flags = 0,
>   1407                  .pmd = pmdp,
>   1408          };
>   1409
>   1410          if (do_set_pmd(&vmf, hpage))
>   1411                  return SCAN_FAIL;
>   1412
>   1413          get_page(hpage);
>   1414          return SCAN_SUCCEED;
>   1415  }
>   1416
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
>

Thanks lkp & apologies here. Anticipating at least one successive
version and will include the fixes there.
